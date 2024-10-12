import 'package:flutter/material.dart';
import 'components/app_background.dart';
import 'package:real_connect/perfil.dart';
import 'components/custom_app_bar.dart';
import 'contas.dart';
// variaveis
var boxShadow = BoxShadow(
  color: Colors.black.withOpacity(0.24),
  spreadRadius: 0,
  blurRadius: 8,
  offset: Offset(0, 3),
);

double iconSize = 32;
Color cardColor = Colors.white;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          const AppBackground(
            child: SizedBox.expand(),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  ProfileSection(), // Seção de perfil
                  const SizedBox(height: 20),
                  GridButtons(),
                  const SizedBox(height: 20),
                  AulasSection(),
                  const SizedBox(height: 20),
                  ClassCard(
                    room: "Sala: 101",
                    subject: "Prog II",
                    time: "19:00",
                    color: Colors.green,
                  ),
                  const SizedBox(height: 10),
                  ClassCard(
                    room: "Sala: 301",
                    subject: "Design",
                    time: "21:00",
                    color: Colors.red,
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

class ProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PerfilPage(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [boxShadow],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person),
            SizedBox(width: 8),
            Text("Aluno(a)"),
          ],
        ),
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
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      children: [
        GridButton(
          icon: Icons.campaign,
          label: "Eventos",
          destination: null, // Ainda não implementado
        ),
        GridButton(
          icon: Icons.receipt_long,
          label: "Pedidos",
          destination: null, // Ainda não implementado
        ),
        GridButton(
          icon: Icons.library_books,
          label: "Biblioteca",
        ),
        GridButton(
          icon: Icons.qr_code,
          label: "Contas",
          destination: ContasPage(), // Redireciona para a página de contas
        ),
        GridButton(
          icon: Icons.table_chart,
          label: "Notas",
          destination: null, // Ainda não implementado
        ),
        GridButton(
          icon: Icons.edit,
          label: "Inscrição",
          destination: null, // Ainda não implementado
        ),
      ],
    );
  }
}

class GridButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? destination;

  GridButton({
    required this.icon,
    required this.label,
    this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (destination != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination!),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Esta funcionalidade ainda não está disponível.'),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [boxShadow],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: iconSize + 4),
            const SizedBox(height: 8),
            Text(label),
          ],
        ),
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
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [boxShadow],
      ),
      child: Text("Aulas"),
    );
  }
}

// Helper function to create a class cardColor component
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
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [boxShadow],
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
                  color: cardColor,
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
