import 'package:flutter/material.dart';
import 'package:real_connect/models/user.dart';
import 'package:real_connect/models/aluno.dart';
import 'package:real_connect/helpers/sql_helper.dart';
import 'package:real_connect/components/app_background.dart';
import 'package:real_connect/models/loggedUser.dart';
import 'components/custom_app_bar.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage>
    with SingleTickerProviderStateMixin {
  Aluno? aluno;
  User? user;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _contatoController = TextEditingController();
  final TextEditingController _apelidoController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Inicializando o AnimationController e o FadeTransition
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _carregarDadosAluno('alunoId');
  }

  Future<void> _carregarDadosAluno(alunoId) async {
    try {
      var data = await DatabaseHelper().getUsuarioAluno(LoggedUser.id);

      if (data != null) {
        setState(() {
          aluno = data['aluno'];
          user = data['user'];
          _contatoController.text = user!.email;
          _apelidoController.text = user!.nome;
        });
        _animationController
            .forward(); // Iniciar a animação após carregar os dados
      } else {
        setState(() {
          aluno = null;
          user = null;
        });
      }
    } catch (e) {
      print('Erro ao carregar dados do aluno: $e');
      setState(() {
        aluno = null;
        user = null;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
            body: aluno == null
                ? const Center(child: CircularProgressIndicator())
                : FadeTransition(
                    opacity: _fadeAnimation,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                color: Colors.white,
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          user!.nome,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'RA: ${aluno!.ra}',
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
                                        labelText: 'Contato',
                                      ),
                                      onSaved: (value) => user!.email = value!,
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      controller: _apelidoController,
                                      decoration: const InputDecoration(
                                        labelText: 'Apelido',
                                      ),
                                      onSaved: (value) => user!.nome = value!,
                                    ),
                                    const SizedBox(height: 20),
                                    AnimatedBuilder(
                                      animation: _animationController,
                                      builder: (context, child) {
                                        return ElevatedButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState!.save();
                                              await DatabaseHelper()
                                                  .atualizarUsuario(
                                                      aluno!.toMap(),
                                                      aluno!.id!);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Dados atualizados com sucesso!')),
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                              horizontal: 20,
                                            ),
                                          ),
                                          child: const Text('Salvar'),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
