import 'package:flutter/material.dart';
import 'package:real_connect/components/app_background.dart';
import 'components/custom_app_bar.dart';

// Modelo de dados mockados para o perfil do aluno
class Aluno {
  final String nome;
  final String ra;
  final String periodo;
  final String sala;
  final String contato;

  Aluno({
    required this.nome,
    required this.ra,
    required this.periodo,
    required this.sala,
    required this.contato,
  });
}

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  // Mock de informações do aluno
  final Aluno aluno = Aluno(
    nome: 'João da Silva',
    ra: '12345678',
    periodo: 'Noturno',
    sala: '301',
    contato: '(11) 99999-9999',
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          // Fundo azul que ocupa toda a tela
          const AppBackground(
            child: SizedBox.expand(),
          ),
          Scaffold(
            backgroundColor:
                Colors.transparent,
            appBar: CustomAppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/images.png'),
                    ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  aluno.nome,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'RA: ${aluno.ra}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Período: ${aluno.periodo}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'Sala: ${aluno.sala}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Contato: ${aluno.contato}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
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
        ],
      ),
    );
  }
}
