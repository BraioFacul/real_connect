import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_balance_wallet),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile or Student section
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 8),
                    Text("Aluno(a)"),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Grid buttons
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  buildGridButton(Icons.campaign, "Eventos"),
                  buildGridButton(Icons.receipt_long, "Pedidos"),
                  buildGridButton(Icons.library_books, "Biblioteca"),
                  buildGridButton(Icons.qr_code, "Contas"),
                  buildGridButton(Icons.table_chart, "Notas"),
                  buildGridButton(Icons.edit, "Inscrição"),
                ],
              ),
              SizedBox(height: 20),

              // Aulas Section
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text("Aulas"),
              ),
              SizedBox(height: 20),

              // Classes (e.g. Prog II and Design)
              buildClassCard("Sala: 101", "Prog II", "19:00", Colors.green),
              SizedBox(height: 10),
              buildClassCard("Sala: 301", "Desing", "21:00", Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create a grid button
  Widget buildGridButton(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  // Helper function to create a class card
  Widget buildClassCard(String room, String subject, String time, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(room, style: TextStyle(color: Colors.white)),
              Text(subject, style: TextStyle(color: Colors.white)),
            ],
          ),
          Text(time, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}