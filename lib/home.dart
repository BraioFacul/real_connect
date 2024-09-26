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
              // Profile or Student section (Componentizado)
              ProfileSection(),

              SizedBox(height: 20),

              // Grid buttons (Componentizado)
              GridButtons(),

              SizedBox(height: 20),

              // Aulas Section (Componentizado)
              AulasSection(),

              SizedBox(height: 20),

              // Classes (Componentizado)
              ClassCard(
                  room: "Sala: 101",
                  subject: "Prog II",
                  time: "19:00",
                  color: Colors.green),
              SizedBox(height: 10),
              ClassCard(
                  room: "Sala: 301",
                  subject: "Design",
                  time: "21:00",
                  color: Colors.red),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper function to create a profile section component
class ProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.24),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.person),
          SizedBox(width: 8),
          Text("Aluno(a)"),
        ],
      ),
    );
  }
}

// Helper function to create a grid button component
class GridButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: [
        GridButton(icon: Icons.campaign, label: "Eventos"),
        GridButton(icon: Icons.receipt_long, label: "Pedidos"),
        GridButton(icon: Icons.library_books, label: "Biblioteca"),
        GridButton(icon: Icons.qr_code, label: "Contas"),
        GridButton(icon: Icons.table_chart, label: "Notas"),
        GridButton(icon: Icons.edit, label: "Inscrição"),
      ],
    );
  }
}

class GridButton extends StatelessWidget {
  final IconData icon;
  final String label;

  GridButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.24),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
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
}

// Helper function to create the aulas section component
class AulasSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.24),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Text("Aulas"),
    );
  }
}

// Helper function to create a class card component
class ClassCard extends StatelessWidget {
  final String room;
  final String subject;
  final String time;
  final Color color;

  ClassCard(
      {required this.room,
      required this.subject,
      required this.time,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left colored section
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                room,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          // Right content section
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    subject,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
}
