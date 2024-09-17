import 'package:flutter/material.dart';
import 'package:real_connect/Home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.blue,
          child: Column(children: [
            Container(
              height: 250,
              width: 400,
              child: Image.asset("assets/images/centro-universistario.png"),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                    height: 640,
                    width: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 100),
                        Text('Enter in your account', style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'AnekMalayalam',
                          fontSize: 24,
                          color: Colors.black,
                        ),),
                        SizedBox(height: 100),
                        Container(
                          width: 400,
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              fillColor:
                                  const Color.fromARGB(255, 218, 218, 218),
                              filled: true,
                              border: null,
                              labelText: 'Email',
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 400,
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {});
                            },
                            obscureText: _passwordVisible,
                            decoration: InputDecoration(
                              labelStyle: null,
                              disabledBorder: null,
                              enabledBorder: null,
                              focusedBorder: null,
                              fillColor:
                                  const Color.fromARGB(255, 218, 218, 218),
                              filled: true,
                              border: null,
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
                          ),
                        ),
                        ElevatedButton(
                          child: Container(
                              width: 150,
                              height: 50,
                              child: Center(
                                  child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          },
                          style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.blue)),
                        )
                      ],
                    ))),
          ])),
    );
  }
}
