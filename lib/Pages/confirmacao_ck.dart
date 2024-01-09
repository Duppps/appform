import 'package:flutter/material.dart';

class ConfirmacaoCK extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "Checklist enviado com sucesso!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text('Voltar à tela inicial'),
          ),
        ],
      ),
    );
  }
}
