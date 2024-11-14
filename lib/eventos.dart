import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'detalheEventos.dart'; // Certifique-se de que o caminho do import está correto
import 'components/app_background.dart';
import 'components/custom_app_bar.dart';

final dio = Dio();

class EventosPage extends StatefulWidget {
  const EventosPage({super.key});

  @override
  State<EventosPage> createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {
  List<dynamic> _eventos = []; // Lista para armazenar eventos

  Future<void> getEventos() async {
    try {
      final response = await dio.get('http://172.32.90.152:9090/api/events');
      setState(() {
        if (response.data is List) {
          _eventos = response.data;
        } else {
          _eventos = [response.data];
        }
      });
    } catch (e) {
      setState(() {
        _eventos = [
          {'error': 'Erro ao carregar eventos: $e'}
        ];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getEventos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: Colors.transparent,
        body: AppBackground(
          child: Center(
            child: _eventos.isEmpty
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: _eventos.length,
                    itemBuilder: (context, index) {
                      var evento = _eventos[index];
                      var nome = evento['name'] ?? 'Evento sem nome';
                      var dataInicio = evento['start_date'] ??
                          'Data de início não disponível';
                      var dataFim = evento['end_date'] ??
                          'Data de término não disponível';
                      var custo = evento['cost'] != null
                          ? 'R\$${evento['cost']}'
                          : 'Gratuito';
                      var participantes =
                          evento['participants_number'] ?? 'N/A';
                      var imageUrl = evento['image_url'] ?? '';

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Imagem do evento com bordas arredondadas e sombra
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: imageUrl.isNotEmpty
                                  ? Image.network(
                                      imageUrl,
                                      width: double.infinity,
                                      height: 220,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: double.infinity,
                                      height: 220,
                                      color: Colors.grey[300],
                                      child: Icon(Icons.event,
                                          size: 100, color: Colors.grey[400]),
                                    ),
                            ),
                            // Informações do evento com bordas e espaçamento
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nome,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF007BFF)),
                                  ),
                                  SizedBox(height: 8),
                                  DetailRow(
                                      icon: Icons.calendar_today,
                                      title: 'Data de Início:',
                                      value: dataInicio.toString()),
                                  DetailRow(
                                      icon: Icons.calendar_today,
                                      title: 'Data de fim:',
                                      value: dataFim.toString()),
                                  DetailRow(
                                      icon: Icons.attach_money,
                                      title: 'Custo:',
                                      value: custo.toString()),
                                  DetailRow(
                                      icon: Icons.group,
                                      title: 'Participantes:',
                                      value: participantes.toString())
                                ],
                              ),
                            ),
                            // Botão para navegar para o detalhe do evento com animação e bordas arredondadas
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EventDetailPage(evento: evento),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF007BFF),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 2,
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Ver Detalhes",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(Icons.arrow_forward_ios,
                                            color: Colors.white, size: 18),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
