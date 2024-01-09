import 'package:flutter/material.dart';
import 'package:appform/Components/list_item.dart';

class UnidadeCanoas extends StatelessWidget {
  const UnidadeCanoas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unidade Canoas"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        child: ListView(
          children: [
            ListItemMenu(
              labelText: 'Checklist Trator',
              icon: const Icon(Icons.fmd_good),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/canoas/checklistTrator',
                );
              },
            ),
            const SizedBox(height: 16),
            ListItemMenu(
              labelText: 'CheckList2',
              icon: const Icon(Icons.fmd_good),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/canoas/checklist2',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
