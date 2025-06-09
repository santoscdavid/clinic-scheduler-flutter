import 'package:flutter/material.dart';

class HistoricPage extends StatelessWidget {
  final String? userId;
  const HistoricPage({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Histórico de Consultas'),
      ),
      body: Center(
        child: Text(
          'Nenhum histórico disponível.',
          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
        ),
      ),
    );
  }
}
