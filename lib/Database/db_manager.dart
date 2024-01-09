import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseManager {
  static final DatabaseManager instance = DatabaseManager._privateConstructor();
  static Database? _database;

  DatabaseManager._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'TheoForm.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ck_trator_Matriz (
        id INTEGER PRIMARY KEY,
        titulo TEXT,
        filial TEXT,
        descricao TEXT,
        pneusDianteiros TEXT,        
        pneusTraseiros TEXT,
        pictures TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  Future<int> insertTratorData(String titulo, String filial, String descricao,
      String pneusDianteiros, String pneusTraseiros, String pictures) async {
    Database db = await database;

    return await db.insert(
      'ck_trator_Matriz',
      {
        'titulo': titulo,
        'filial': filial,
        'descricao': descricao,
        'pneusDianteiros': pneusDianteiros,
        'pneusTraseiros': pneusTraseiros,
        'pictures': pictures,
        'updated_at': DateTime.now().toLocal().toString()
      },
    );
  }

  Future<List<Map<String, dynamic>>> searchInDatabase() async {
    Database db = await database;

    List<Map<String, dynamic>> result = await db.query('ck_trator_Matriz');

    return result;
  }
}
