import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DirectoryApp {
  static Future<String> obterCaminhoPastaImagens() async {
    Directory pastaApp = await getApplicationDocumentsDirectory();
    String pastaImagens = '${pastaApp.path}/theoforms';

    if (!Directory(pastaImagens).existsSync()) {
      Directory(pastaImagens).createSync(recursive: true);
    }

    return pastaImagens;
  }
}
