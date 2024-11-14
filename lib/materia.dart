import 'package:flutter/material.dart';
import 'package:real_connect/helpers/sql_helper.dart';
import 'package:real_connect/components/app_background.dart';
import 'components/custom_app_bar.dart';

class MateriaScreen extends StatefulWidget {
  @override
  _MateriaScreenState createState() => _MateriaScreenState();
}

class _MateriaScreenState extends State<MateriaScreen> {
  List<Map<String, dynamic>> materias = [];
  String situacaoGeral = "APROVADO";

  @override
  void initState() {
    super.initState();
    _loadMaterias();
  }

  Future<void> _loadMaterias() async {
    try {
      var data = await DatabaseHelper().getMaterias();
      setState(() {
        materias = data;
        _calcularSituacaoGeral();
      });
    } catch (e) {
      print('Erro ao carregar dados das matérias: $e');
    }
  }

  void _calcularSituacaoGeral() {
    bool temReprovado = false;
    bool temExame = false;

    for (var materia in materias) {
      if (materia['situacao'] == 'REPROVADO') {
        temReprovado = true;
        break;
      }
      if (materia['situacao'] == 'EXAME') {
        temExame = true;
      }
    }

    setState(() {
      if (temReprovado) {
        situacaoGeral = 'REPROVADO';
      } else if (temExame) {
        situacaoGeral = 'EM EXAME';
      } else {
        situacaoGeral = 'APROVADO';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppBackground(child: SizedBox.expand()),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(),
            body: materias.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Card para a situação geral
                        Card(
                          color: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: Icon(
                              situacaoGeral == 'APROVADO'
                                  ? Icons.check_circle_outline
                                  : situacaoGeral == 'EM EXAME'
                                      ? Icons.warning_amber_outlined
                                      : Icons.cancel_outlined,
                              color: situacaoGeral == 'APROVADO'
                                  ? Colors.green
                                  : situacaoGeral == 'EM EXAME'
                                      ? Colors.amber
                                      : Colors.red,
                              size: 40,
                            ),
                            title: Text(
                              'Situação: $situacaoGeral',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            trailing: situacaoGeral == 'APROVADO'
                                ? Icon(Icons.check, color: Colors.green)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Lista de matérias
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: materias.length,
                          itemBuilder: (context, index) {
                            final materia = materias[index];
                            return MateriaCard(materia: materia);
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class MateriaCard extends StatelessWidget {
  final Map<String, dynamic> materia;

  const MateriaCard({required this.materia});

  @override
  Widget build(BuildContext context) {
    Color cardColor;
    Color shadowColor;
    IconData iconData;

    // Definir cor e ícone com base na situação
    switch (materia['situacao']) {
      case 'APROVADO':
        cardColor = const Color(0xFFB4E197); // Verde claro
        shadowColor = Colors.green.withOpacity(0.4);
        iconData = Icons.check_circle_outline;
        break;
      case 'EXAME':
        cardColor = const Color(0xFFFFE0B2); // Amarelo claro
        shadowColor = Colors.amber.withOpacity(0.4);
        iconData = Icons.warning_amber_outlined;
        break;
      case 'REPROVADO':
        cardColor = const Color(0xFFFFA8A8); // Vermelho claro
        shadowColor = Colors.red.withOpacity(0.4);
        iconData = Icons.cancel_outlined;
        break;
      default:
        cardColor = Colors.grey[200]!;
        shadowColor = Colors.grey.withOpacity(0.4);
        iconData = Icons.help_outline;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: cardColor, // Card principal agora colorido
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 8,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Seção branca à esquerda com ícone
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white, // A parte colorida agora é branca
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 6,
                  offset: const Offset(3, 3),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                iconData,
                size: 32,
                color: cardColor, // Ícone colorido com a cor do status
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    materia['nome'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black, // Texto agora branco
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Situação: ${materia['situacao']}',
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Média: ${materia['media'].toString()}',
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
