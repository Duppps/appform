import 'package:flutter/material.dart';
import 'dart:io';
import 'fila/appbar_fila.dart';
import 'fila/fab_fila.dart';
import 'package:appform/Components/list_item.dart';
import 'package:appform/Database/db_manager.dart';
import 'package:appform/Components/app_directory.dart';

class FilaPage extends StatefulWidget {
  FilaPage({Key? key}) : super(key: key);

  @override
  _FilaPageState createState() => _FilaPageState();
}

class _FilaPageState extends State<FilaPage> {
  late Future<List<Map<String, dynamic>>> searchResult;

  @override
  void initState() {
    super.initState();
    searchResult = DatabaseManager.instance
        .searchInDatabase(); // Seu critério de busca aqui
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getFilaAppBar(),
      floatingActionButton: getFab(context),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: searchResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('Nenhum resultado encontrado.');
          } else {
            return Container(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 20,
              ),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  String imagens = snapshot.data![index]['imgPneusDianteiros'];
                  String labelText =
                      "${snapshot.data![index]['filial']} - ${snapshot.data![index]['titulo']} - ${snapshot.data![index]['created_at']}";
                  return ListItemMenu(
                    labelText: labelText,
                    icon: const Icon(Icons.pending_actions),
                    onTap: () {
                      _modalImg(context, imagens);
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  _modalImg(BuildContext context, String imagens) async {
    List<String> listaItens = imagens.split(';');
    String caminhoImagem = await DirectoryApp.obterCaminhoPastaImagens();
    String imagem = '$caminhoImagem/${listaItens[0]}';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Fotos Anexadas'),
          content: Container(
            width: 90,
            height: 90,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: Image.file(File(imagem), fit: BoxFit.cover),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Fechar"),
            ),
          ],
        );
      },
    );
  }
}
