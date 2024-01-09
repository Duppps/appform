import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:appform/Pages/home_page.dart';
import 'package:appform/Pages/unidades/matriz.dart';
import 'package:appform/Pages/unidades/canoas.dart';
import 'package:appform/Components/theme_manager.dart';
import 'package:appform/Pages/CheckLists/Matriz/ck_Trator.dart';
import 'package:appform/Pages/fila_page.dart';
import 'package:appform/Pages/confirmacao_ck.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Théo Forms',
      home: AppMain(),
    );
  }
}

class AppMain extends StatefulWidget {
  @override
  _AppMainState createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
  int _selectedIndex = 0;
  final screens = [HomePage(), FilaPage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Théo Forms',
      home: Scaffold(
        body: screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud),
              label: 'Fila',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedItemColor: Colors.red,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/matriz': (context) => UnidadeMatriz(),
        '/canoas': (context) => UnidadeCanoas(),
        '/matriz/checklistTrator': (context) => CKTrator(),
        '/canoas/checklistTrator': (context) => CKTrator(),
        '/confirmado': (context) => ConfirmacaoCK()
      },
      theme: ThemeData(
        primarySwatch: generateMaterialColor(const Color(0xfff03a2e)),
        fontFamily: 'Roboto', // Fonte padrão
      ),
      darkTheme: ThemeData.dark(),
      themeMode: context.watch<ThemeProvider>().themeMode,
    );
  }

  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1.0),
    });
  }
}
