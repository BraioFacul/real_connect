import 'package:flutter/material.dart';

class PagamentoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagamento'),
      ),
      body: Center(
        child: Text(
          'Página de Pagamento',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
