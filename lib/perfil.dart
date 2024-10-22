import 'package:flutter/material.dart';
import 'package:real_connect/models/aluno.dart';
import 'package:real_connect/helpers/sql_helper.dart';
import 'package:real_connect/components/app_background.dart';
import 'components/custom_app_bar.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Aluno? aluno; // Modifique para Aluno opcional até que seja carregado
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _contatoController = TextEditingController();
  final TextEditingController _apelidoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarDadosAluno(); // Carregar os dados ao inicializar a página
  }

  Future<void> _carregarDadosAluno() async {
    try {
      var alunoData = await DatabaseHelper().getUsuarios();
      if (alunoData.isNotEmpty) {
        setState(() {
          aluno = Aluno.fromMap(alunoData.first);
          _contatoController.text = aluno!.contato;
          _apelidoController.text = aluno!.apelido;
        });
      } else {
        // Tratar caso não haja alunos no banco de dados
        setState(() {
          aluno =
              null; // Ou você pode exibir uma mensagem de "Nenhum aluno encontrado"
        });
      }
    } catch (e) {
      // Se houver algum erro na leitura do banco de dados, trate-o aqui
      print('Erro ao carregar dados do aluno: $e');
      setState(() {
        aluno = null;
      });
    }
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
            body: aluno ==
                    null // Exibir um indicador de carregamento até que o aluno seja carregado
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            Card(
                              color: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          aluno!
                                              .nome, // Exibe o nome do aluno carregado
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'RA: ${aluno!.ra}', // Exibe o RA do aluno carregado
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      controller: _contatoController,
                                      decoration: const InputDecoration(
                                          labelText: 'Contato'),
                                      onSaved: (value) =>
                                          aluno!.contato = value!,
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      controller: _apelidoController,
                                      decoration: const InputDecoration(
                                          labelText: 'Apelido'),
                                      onSaved: (value) =>
                                          aluno!.apelido = value!,
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          // Atualiza os dados do aluno no banco de dados
                                          await DatabaseHelper()
                                              .atualizarUsuario(
                                                  aluno!.toMap(), aluno!.id!);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Dados atualizados com sucesso!')),
                                          );
                                        }
                                      },
                                      child: const Text('Salvar'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
