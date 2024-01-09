import 'package:flutter/material.dart';
import 'package:appform/Components/theme_manager.dart';
import 'package:provider/provider.dart';

Drawer getHomeDrawer(BuildContext context) {
  return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
    UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Color(0xfff03a2e),
      ),
      accountName: Text("Ruan Vasconcelos"),
      accountEmail: Text("ruan@theotransportes.com.br"),
      currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text("RV", style: TextStyle(fontSize: 40))),
    ),
    ListTile(
      leading: Icon(
        Icons.settings,
        color: Color(0xfff03a2e),
      ),
      title: Text("Configurações"),
    ),
    ListTile(
      title: Text('Alterar Tema'),
      trailing: IconButton(
        icon: Icon(Icons.lightbulb),
        onPressed: () {
          context.read<ThemeProvider>().toggleTheme();
        },
      ),
    )
  ]));
}
