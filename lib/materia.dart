import 'package:flutter/material.dart';
import 'helpers/sql_helper.dart';

class MateriaScreen extends StatefulWidget {
  @override
  _MateriaScreenState createState() => _MateriaScreenState();
}

class _MateriaScreenState extends State<MateriaScreen> {
  List<Map<String, dynamic>> materias = [];

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
      });
    } catch (e) {
      print('Erro ao carregar dados do aluno: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matérias'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: materias.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
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
                  color: cardColor,
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(iconData, size: 40),
                    title: Text(materia['nome'],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        'Situação: ${materia['situacao']} \nMédia: ${materia['media'].toString()}'),
                  ),
                );
              },
            ),
    );
  }
}
