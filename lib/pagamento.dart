import 'package:flutter/material.dart';

class PagamentoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card para o total
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total: R\$ 500,00',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Primeiro card: Débito
            Card(
              child: ListTile(
                title: Text('Débito'),
                trailing: Icon(Icons.credit_card, color: Colors.green),
              ),
            ),
            SizedBox(height: 8),

            // Segundo card: Boleto
            Card(
              child: ListTile(
                title: Text('Boleto'),
                trailing: Icon(Icons.qr_code_2, color: Colors.blue),
              ),
            ),
            SizedBox(height: 8),

            // Terceiro card: Crédito
            Card(
              child: ListTile(
                title: Text('Crédito'),
                trailing: Icon(Icons.credit_card, color: Colors.green),
              ),
            ),
            SizedBox(height: 8),

            // Quarto card: Pix - Copia e cola
            Card(
              child: ListTile(
                title: Text('Pix - Copia e cola'),
                trailing: Icon(Icons.pix, color: Colors.teal),
              ),
            ),
            SizedBox(height: 16),

            // Card maior com QR Code centralizado
            Card(
              child: Container(
                height: 180, // Tamanho de 3 cards aproximadamente
                child: Center(
                  child: Icon(
                    Icons.qr_code,
                    size: 100,
                    color: Colors.grey,
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
