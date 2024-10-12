import 'package:flutter/material.dart';
import 'components/app_background.dart'; // Importando o AppBackground
import 'home.dart'; // Importando a HomePage para navegar de volta
import 'pagamento.dart'; // Importando a página de pagamento

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
    final double cardWidth = screenWidth - 76; // Largura da tela menos 38px de cada lado

    return MaterialApp(
      home: Stack(
        children: [
          const AppBackground( // Usando AppBackground como fundo
            child: SizedBox.expand(), // Para ocupar todo o espaço disponível
          ),
          Scaffold(
            backgroundColor: Colors.transparent, // Fundo do Scaffold transparente
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38.0),
              child: Column(
                children: [
                  SizedBox(height: 29), // Espaçamento no topo da página
                  // Botão de Voltar
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Retorna à página anterior
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.black, // Cor da seta
                        ), // Seta sem mudança de cor
                        SizedBox(width: 8), // Espaçamento entre a seta e o texto
                        Text(
                          'Voltar',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black, // Cor do texto
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50), // Espaçamento entre o botão e o card de Outubro 2024
                  // Card de Outubro 2024
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: cardColor, // Usando a cor do card
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
                  SizedBox(height: 50), // Garantindo 50px entre o título e os boletos
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PagamentoPage()), // Navega para a página de pagamento
                      );
                    },
                    child: BoletoCard(
                      width: cardWidth,
                      status: 'Não Pago',
                      date: '05/10/2024',
                      icon: Icons.pending_actions,
                      iconColor: Colors.orange,
                      bgColor: Colors.orange[100],
                    ),
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
                  SizedBox(height: 16),
                  BoletoCard(
                    width: cardWidth,
                    status: 'Pago',
                    date: '05/08/2024',
                    icon: Icons.check_circle,
                    iconColor: Colors.green,
                    bgColor: Colors.green[100],
                    isPaid: true,
                  ),
                  SizedBox(height: 16),
                  BoletoCard(
                    width: cardWidth,
                    status: 'Pago',
                    date: '05/07/2024',
                    icon: Icons.check_circle,
                    iconColor: Colors.green,
                    bgColor: Colors.green[100],
                    isPaid: true,
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
    return Container(
      width: width,
      height: 150, // Altura dos cards
      decoration: BoxDecoration(
        color: cardColor, // Usando a cor do card
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          boxShadow,
        ],
      ),
      child: Row(
        children: [
          // Seção da data à esquerda
          Expanded(
            flex: 3, // 3/4 da largura do card para a data
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
          // Seção de status à direita (1/4 da largura do card)
          Expanded(
            flex: 1, // 1/4 do card para o status
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
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
    );
  }
}

void main() {
  runApp(ContasPage());
}
