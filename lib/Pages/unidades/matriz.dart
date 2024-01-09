import 'package:flutter/material.dart';
import 'package:appform/Components/list_item.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';

class UnidadeMatriz extends StatelessWidget {
  const UnidadeMatriz({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Text("Unidade Matriz"),
          BreadCrumb(
            items: <BreadCrumbItem>[
              BreadCrumbItem(content: Text('Home')),
              BreadCrumbItem(content: Text('Matriz')),
            ],
            divider: Icon(Icons.chevron_right),
          )
        ]),
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
                  '/matriz/checklistTrator',
                );
              },
            ),
            ListItemMenu(
              labelText: 'CheckList2',
              icon: const Icon(Icons.fmd_good),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/matriz/checklist2',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
