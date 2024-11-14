import 'package:flutter/material.dart';
import 'components/app_background.dart';

class BoletoDetalhesPage extends StatelessWidget {
  final double valorTotal;

  BoletoDetalhesPage({required this.valorTotal});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth - 76;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          const AppBackground(
            child: SizedBox.expand(),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38.0),
              child: Column(
                children: [
                  SizedBox(height: 29),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back, color: Colors.black),
                        SizedBox(width: 8),
                        Text(
                          'Voltar',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),

                  // Card para valor total
                  _buildInfoCard(
                      'Total',
                      'R\$ ${valorTotal.toStringAsFixed(2)}',
                      cardWidth,
                      Colors.black),

                  // Card para Descontos
                  SizedBox(height: 16),
                  _buildInfoCard(
                      'Descontos', 'R\$ 250,00', cardWidth, Colors.red),

                  // Card para Tipo
                  SizedBox(height: 16),
                  _buildInfoCardWithIcon(
                    'Tipo',
                    'Débito',
                    Icons.credit_card,
                    Colors.blue,
                    cardWidth,
                  ),

                  // Card para Mensalidade Flex
                  SizedBox(height: 16),
                  _buildInfoCardWithIcon(
                    'Mensalidade Flex',
                    ' ',
                    Icons.check,
                    Colors.green,
                    cardWidth,
                  ),

                  // Card para Incentivos
                  SizedBox(height: 16),
                  _buildInfoCardWithIcon(
                    'Incentivos',
                    ' ',
                    Icons.close,
                    Colors.red,
                    cardWidth,
                  ),

                  // Card para Multas
                  SizedBox(height: 16),
                  _buildInfoCardWithIcon(
                    'Multas',
                    ' ',
                    Icons.close,
                    Colors.red,
                    cardWidth,
                  ),

                  // Card para Recibo
                  SizedBox(height: 16),
                  _buildInfoCardWithIcon(
                    'Recibo',
                    'Baixar',
                    Icons.download,
                    Colors.blue,
                    cardWidth,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      String title, String value, double width, Color textColor) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCardWithIcon(String title, String value, IconData icon,
      Color iconColor, double width) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Icon(icon, color: iconColor),
            ],
          ),
        ],
      ),
    );
  }
}
