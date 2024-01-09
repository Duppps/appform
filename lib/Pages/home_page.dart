import 'package:flutter/material.dart';
import 'home/drawer_home.dart';
import 'package:appform/Components/list_item.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: getHomeDrawer(context),
        appBar: AppBar(
          title: const Text("Théo Forms"),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 20,
          ),
          child: ListView(
            children: [
              ListItemMenu(
                labelText: 'Matriz',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/matriz',
                  );
                },
                icon: const Icon(Icons.home),
              ),
              ListItemMenu(
                labelText: 'Canoas',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/canoas',
                  );
                },
                icon: const Icon(Icons.fmd_good),
              ),
              ListItemMenu(
                labelText: 'Mogi das Cruzes',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/unidade',
                  );
                },
                icon: const Icon(Icons.fmd_good),
              ),
              ListItemMenu(
                labelText: 'Outra Unidade',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/unidade',
                  );
                },
                icon: const Icon(Icons.fmd_good),
              ),
            ],
          ),
        ));
  }
}
