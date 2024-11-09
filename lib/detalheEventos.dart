import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  final Map<String, dynamic> evento;

  EventDetailPage({required this.evento});

  @override
  Widget build(BuildContext context) {
    var nome = evento['name'] ?? 'Evento sem nome';
    var dataInicio = evento['start_date'] ?? 'Data de início não disponível';
    var dataFim = evento['end_date'] ?? 'Data de término não disponível';
    var custo = evento['cost'] != null ? 'R\$${evento['cost']}' : 'Gratuito';
    var participantes = evento['participants_number'] ?? 'N/A';
    var imageUrl = evento['image_url'] ?? '';
    var descricao = evento['description'] ?? 'Nenhuma descrição disponível';

    return Scaffold(
      appBar: AppBar(
        title: Text(nome, style: TextStyle(fontSize: 20)),
        backgroundColor: Color(0xFF007BFF),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exibição da imagem
            if (imageUrl.isNotEmpty)
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            // Conteúdo dos detalhes do evento
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome do evento
                  Text(
                    nome,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF007BFF),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Detalhes do evento em Cards
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailRow(
                              icon: Icons.calendar_today,
                              title: 'Data de Início:',
                              value: dataInicio),
                          DetailRow(
                              icon: Icons.calendar_today,
                              title: 'Data de Término:',
                              value: dataFim),
                          DetailRow(
                              icon: Icons.attach_money,
                              title: 'Custo:',
                              value: custo),
                          DetailRow(
                              icon: Icons.group,
                              title: 'Participantes:',
                              value: participantes.toString()),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Descrição do evento
                  Text(
                    'Descrição do evento:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF007BFF),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    descricao,
                    style: TextStyle(fontSize: 16, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget reutilizável para exibir as linhas de detalhes do evento
class DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const DetailRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF007BFF), size: 24),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
