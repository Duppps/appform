import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:appform/Components/app_directory.dart';

class AvaliacaoButtons extends StatefulWidget {
  final String labelText;
  final void Function(String) onPressed;
  final void Function(String)? onImageAdded;

  const AvaliacaoButtons({
    Key? key,
    required this.labelText,
    required this.onPressed,
    this.onImageAdded,
  }) : super(key: key);

  @override
  _AvaliacaoButtonsState createState() => _AvaliacaoButtonsState();
}

Future<void> _requestGalleryPermission() async {
  await Permission.photos.request();
}

class _AvaliacaoButtonsState extends State<AvaliacaoButtons> {
  int selectedButtonIndex = -1;
  List<Widget> containers = [];
  late String nomeArquivo;

  @override
  void initState() {
    super.initState();
    nomeArquivo =
        '${widget.labelText}_${DateTime.now().millisecondsSinceEpoch}.png';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.labelText,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildAvaliacaoButton(0, 'N/A'),
              buildAvaliacaoButton(1, 'Conforme'),
              buildAvaliacaoButton(2, 'Não conforme'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Observação (opcional)',
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(
                  Icons.camera_alt,
                  size: 35,
                  color: Colors.red,
                ),
                onPressed: () {
                  _showMediaDialog(context);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  ElevatedButton buildAvaliacaoButton(int index, String label) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedButtonIndex = index;
        });

        widget.onPressed(label);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            index == selectedButtonIndex ? const Color(0xffba1111) : Colors.red,
      ),
      child: Text(label),
    );
  }

  Future<File?> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      String pastaImagens = await obterCaminhoPastaImagens();
      String nomeArquivoCompleto = '$pastaImagens/$nomeArquivo';

      return await File(pickedImage.path).copy(nomeArquivoCompleto);
    }

    return null;
  }

  Future<String> obterCaminhoPastaImagens() async {
    String pastaImagens = await DirectoryApp.obterCaminhoPastaImagens();

    return pastaImagens;
  }

  _showMediaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Fotos Anexadas'),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Wrap(
              children: [
                _buildAddMediaButton(),
                for (Widget container in containers) container,
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Fechar"))
          ],
        );
      },
    );
  }

  Widget _buildAddMediaButton() {
    return Container(
      width: 90,
      height: 90,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          _showMediaSourceDialog(context);
        },
      ),
    );
  }

  _showMediaSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecione a Fonte de Mídia'),
          content: Wrap(
            children: [
              ElevatedButton(
                onPressed: () async {
                  await _requestGalleryPermission();
                  File? img = await _pickImage();
                  Navigator.of(context).pop();
                  _addModal(img);
                },
                child: const Text('Galeria'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Câmera'),
              ),
            ],
          ),
        );
      },
    );
  }

  _addModal(File? img) {
    setState(() {
      if (img != null) {
        containers.add(
          Container(
            width: 90,
            height: 90,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: Image.file(img, fit: BoxFit.cover),
          ),
        );

        if (widget.onImageAdded != null) {
          widget.onImageAdded!(nomeArquivo);
        }
      } else {
        containers.add(
          Container(
            width: 90,
            height: 90,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
        );
      }
    });
  }
}
