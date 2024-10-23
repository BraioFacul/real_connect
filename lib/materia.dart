import 'package:flutter/material.dart';
import 'package:real_connect/helpers/sql_helper.dart';
import 'package:real_connect/components/app_background.dart';
import 'components/custom_app_bar.dart'; // Importando o CustomAppBar

class MateriaScreen extends StatefulWidget {
  @override
  _MateriaScreenState createState() => _MateriaScreenState();
}

class _MateriaScreenState extends State<MateriaScreen> {
  List<Map<String, dynamic>> materias = [];
  String situacaoGeral = "APROVADO"; // Status geral padrão

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
        _calcularSituacaoGeral(); // Atualiza o status geral com base nas matérias
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
        break; // Se houver uma matéria reprovada, o status geral já é "REPROVADO"
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
          const AppBackground(child: SizedBox.expand()), // Aplicando o background
          Scaffold(
            backgroundColor: Colors.transparent, // Deixar o fundo transparente
            appBar: CustomAppBar(), // Usando o CustomAppBar
            body: materias.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Primeiro card com a situação geral
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
                            title: Text('Situação: $situacaoGeral',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                            trailing: situacaoGeral == 'APROVADO'
                                ? Icon(Icons.check, color: Colors.green)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Cards das matérias
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: materias.length,
                          itemBuilder: (context, index) {
                            final materia = materias[index];
                            Color cardColor;
                            IconData iconData;

                            switch (materia['situacao']) {
                              case 'APROVADO':
                                cardColor = Colors.green[100]!;
                                iconData = Icons.check_circle_outline;
                                break;
                              case 'EXAME':
                                cardColor = Colors.amber[100]!;
                                iconData = Icons.warning_amber_outlined;
                                break;
                              case 'REPROVADO':
                                cardColor = Colors.red[100]!;
                                iconData = Icons.cancel_outlined;
                                break;
                              default:
                                cardColor = Colors.grey[100]!;
                                iconData = Icons.help_outline;
                            }

                            return Card(
                              color: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: ListTile(
                                leading: Icon(iconData, size: 40),
                                title: Text(materia['nome'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                    'Situação: ${materia['situacao']} \nMédia: ${materia['media'].toString()}'),
                                tileColor: cardColor,
                              ),
                            );
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
