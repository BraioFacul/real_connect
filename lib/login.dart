import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          color: Colors.blue,
          child: Column(children: [
            Container(
              height: 300,
              width: 400,
              child: Image(
                  image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCT5fsVW3aLFQGktcfHOIlES0OTiaiGhMTBA&s")),
            ),
            Padding(
                padding: EdgeInsets.all(3),
                child: Container(
                    height: 600,
                    width: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 100),
                        Container(
                          width: 400,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 400,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
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
                          onPressed: () {},
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
    ));
  }
}
