import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:appform/Database/db_manager.dart';
import 'package:appform/Components/Checklist_Components/item_avaliacao.dart';

class CKTrator extends StatefulWidget {
  const CKTrator({super.key});

  @override
  CKTratorState createState() {
    return CKTratorState();
  }
}

class CKTratorState extends State<CKTrator> {
  final _formKey = GlobalKey<FormState>();
  final _textFieldController = TextEditingController();

  TextEditingController dateInput = TextEditingController();
  String pneusDianteiros = '';
  List<String> pictures = [];

  String pneusTraseiros = '';

  @override
  void initState() {
    dateInput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Checklist Trator"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: dateInput,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        dateInput.text = formattedDate;
                      });
                    } else {}
                  },
                ),
                SizedBox(height: 30),
                Text(
                  'Descrição:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Teste'),
                  controller: _textFieldController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                AvaliacaoButtons(
                  labelText: 'Pneus Dianteiros: ',
                  onPressed: (label) {
                    setState(() {
                      pneusDianteiros = label;
                    });
                  },
                  onImageAdded: (String fileName) {
                    setState(() {
                      pictures.add(fileName);
                    });
                  },
                ),
                AvaliacaoButtons(
                  labelText: 'Pneus Traseiros: ',
                  onPressed: (label) {
                    setState(() {
                      pneusTraseiros = label;
                    });
                  },
                ),
                SizedBox(height: 30),
                Row(children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        sendDataToDatabase(_textFieldController.text,
                            pneusDianteiros, pictures, pneusTraseiros);
                      }
                    },
                    child: const Text('Enviar'),
                  )),
                ])
              ],
            ),
          ),
        )));
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  void sendDataToDatabase(
      descricaoTeste, pneusdianteiros, picturesCK, pneustraseiros) async {
    final dbManager = DatabaseManager.instance;

    // ignore: unnecessary_null_comparison
    if (dbManager != null) {
      String descricao = descricaoTeste;
      String pneusDianteiros = pneusdianteiros;
      String pneusTraseiros = pneustraseiros;
      String pictures = picturesCK.join('; ');

      int result = await dbManager.insertTratorData('Trator', 'Matriz',
          descricao, pneusDianteiros, pneusTraseiros, pictures);

      if (result != 0) {
        _textFieldController.clear();
        Navigator.pushNamed(context, '/confirmado');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save data')),
        );
      }
    }
  }
}
