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

class _PerfilPageState extends State<PerfilPage> {
  Aluno? aluno;
  User? user;
  final _formKey = GlobalKey<FormState>();

  // Controllers para os campos de entrada
  final TextEditingController _contatoController = TextEditingController();
  final TextEditingController _apelidoController = TextEditingController();
  final TextEditingController _raController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarDadosAluno();
  }

  Future<void> _carregarDadosAluno() async {
    try {
      var data = await DatabaseHelper().getUsuarioAluno(LoggedUser.id);
      if (data != null) {
        setState(() {
          aluno = data['aluno'];
          user = data['user'];
          _contatoController.text = user!.email;
          _apelidoController.text = user!.nome;
          _raController.text = aluno!.ra.toString();
          _idadeController.text = user!.idade?.toString() ?? '';
          _enderecoController.text = user!.endereco ?? '';
          _cidadeController.text = user!.cidade ?? '';
        });
      }
    } catch (e) {
      print('Erro ao carregar dados do aluno: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double cardTopPosition = MediaQuery.of(context).size.height * 0.1;

    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: CustomAppBar(),
      body: aluno == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                const AppBackground(child: SizedBox.expand()),
                Container(
                  margin: EdgeInsets.only(top: cardTopPosition),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - cardTopPosition,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: _raController,
                          label: 'RA',
                          readOnly: true,
                          icon: Icons.school,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: _contatoController,
                          label: 'Contato',
                          icon: Icons.email,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: _apelidoController,
                          label: 'Apelido',
                          icon: Icons.person,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: _idadeController,
                          label: 'Idade',
                          icon: Icons.cake,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: _enderecoController,
                          label: 'Endereço',
                          icon: Icons.home,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: _cidadeController,
                          label: 'Cidade',
                          icon: Icons.location_city,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: _salvarDados,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                          ),
                          child: const Text(
                            'Salvar',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool readOnly = false,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon, color: Colors.blue[800]) : null,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      ),
    );
  }

  Future<void> _salvarDados() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Atualizar os objetos `aluno` e `user` com os valores dos controladores
      aluno = Aluno(
        id: aluno!.id,
        ra: _raController.text,
        periodo: aluno!.periodo,
        curso: aluno!.curso,
      );

      user = User(
        id: user!.id,
        nome: _apelidoController.text,
        sobrenome: user!.sobrenome,
        senha: user!.senha,
        idade: int.tryParse(_idadeController.text) ?? user!.idade,
        email: _contatoController.text,
        dataNascimento: user!.dataNascimento,
        sexo: user!.sexo,
        endereco: _enderecoController.text,
        cidade: _cidadeController.text,
      );

      // Preparar os dados para salvar
      Map<String, dynamic> alunoData = aluno!.toMap();
      Map<String, dynamic> userData = user!.toMap();

      print('Atualizando Aluno: $alunoData');
      print('Atualizando Usuário: $userData');

      try {
        await DatabaseHelper().atualizarAlunoEUsuario(
          alunoData,
          userData,
          aluno!.id!,
          user!.id!,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dados atualizados com sucesso!')),
        );
      } catch (e) {
        print('Erro ao atualizar dados: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao atualizar dados')),
        );
      }
    }
  }
}
