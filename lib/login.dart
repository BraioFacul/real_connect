import 'package:flutter/material.dart';
import 'package:real_connect/Home.dart';
import 'package:flutter/gestures.dart';
import 'package:real_connect/helpers/sql_helper.dart';
import 'package:real_connect/models/aluno.dart';
import 'package:real_connect/models/loggedUser.dart';
import 'package:real_connect/models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _passwordVisible = true;
  Aluno? aluno;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      var result = await DatabaseHelper().login(_email, _password);
      if (result.isNotEmpty) {

        LoggedUser.id = User.fromMap(result.first!).id;
        print("Usuário Logado: ${LoggedUser.id}");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid Email or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: Column(children: [
          SizedBox(height: windowHeight * 0.03),
          Container(
            height: windowHeight * 0.15,
            child: Image.asset("assets/images/centro-universistario.png"),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: windowHeight * 0.05),
            child: Container(
              height: windowHeight * 0.7,
              width: windowWidth * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: windowHeight * 0.06),
                    Text(
                      'Entre na sua conta',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'AnekMalayalam',
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: windowHeight * 0.04),
                    SizedBox(
                      width: windowWidth * 0.8,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          fillColor: const Color.fromARGB(255, 218, 218, 218),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Coloque o seu Email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _email = value;
                        },
                      ),
                    ),
                    SizedBox(height: windowHeight * 0.04),
                    SizedBox(
                      width: windowWidth * 0.8,
                      child: TextFormField(
                        obscureText: _passwordVisible,
                        decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 218, 218, 218),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          labelText: 'Senha',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Coloque sua senha';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _password = value;
                        },
                      ),
                    ),
                    SizedBox(height: windowHeight * 0.03),
                    Text('Esqueceu sua senha?'),
                    SizedBox(height: windowHeight * 0.03),
                    ElevatedButton(
                      onPressed: _login,
                      child: Container(
                        width: 150,
                        height: 50,
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    ));
  }
}
