import 'package:flutter/material.dart';
import 'components/app_background.dart'; // Importando o AppBackground
import 'home.dart'; // Importando a HomePage para navegar de volta
import 'pagamento.dart'; // Importando a página de pagamento
import 'boleto_detalhes_page.dart'; // Importando a página de detalhes do boleto
import 'components/custom_app_bar.dart'; // Certifique-se de importar seu CustomAppBar

// Variáveis
var boxShadow = BoxShadow(
  color: Colors.black.withOpacity(0.1),
  spreadRadius: 0,
  blurRadius: 8,
  offset: Offset(0, 3),
);

Color cardColor = Colors.white; // Cor do card

class ContasPage extends StatefulWidget {
  @override
  _ContasPageState createState() => _ContasPageState();
}

class _ContasPageState extends State<ContasPage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          const AppBackground(child: SizedBox.expand()),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(), // Usando o CustomAppBar aqui
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38.0),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Outubro 2024',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  BoletoCard(
                    width: cardWidth,
                    status: 'Não Pago',
                    date: '05/10/2024',
                    icon: Icons.pending_actions,
                    iconColor: Colors.orange,
                    bgColor: Colors.orange[100],
                  ),
                  SizedBox(height: 16),
                  BoletoCard(
                    width: cardWidth,
                    status: 'Pago',
                    date: '05/09/2024',
                    icon: Icons.check_circle,
                    iconColor: Colors.green,
                    bgColor: Colors.green[100],
                    isPaid: true,
                  ),
                  // Adicione mais cards se necessário
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BoletoCard extends StatelessWidget {
  final String status;
  final String date;
  final IconData icon;
  final Color iconColor;
  final Color? bgColor;
  final bool isPaid;
  final double width;

  BoletoCard({
    required this.status,
    required this.date,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    this.isPaid = false,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        double valorTotal =
            500.00; // Passando o valor de 500.00 para a página de detalhes do boleto

        if (isPaid) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BoletoDetalhesPage(valorTotal: valorTotal),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PagamentoPage()),
          );
        }
      },
      child: Container(
        width: width,
        height: 70,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            boxShadow,
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    date,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, color: iconColor, size: 32),
                      SizedBox(height: 4),
                      Text(
                        status,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: iconColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(ContasPage());
}
