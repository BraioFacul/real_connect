import 'package:flutter/material.dart';
import 'package:real_connect/Home.dart';
import 'package:flutter/gestures.dart';
import './Users.dart';

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

  final Users users = Users();

Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      // Verifique se o login é bem-sucedido
      bool success = await users.login(_email, _password);
      if (success) {
        // Se o login for bem-sucedido, redirecione para a página inicial
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Exiba uma mensagem de erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid email or password')),
        );
      }
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: Column(children: [
          Container(
            height: 250,
            width: 350,
            child: Image.asset("assets/images/centro-universistario.png"),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              height: 640,
              width: 450,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 75),
                    Text(
                      'Enter in your account',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'AnekMalayalam',
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 75),
                    TextFormField(
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
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
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
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    SizedBox(height: 20),
                    Text('Esqueceu sua senha?'),
                    SizedBox(height: 100),
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
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 25)
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
