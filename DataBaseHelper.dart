import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Databasehelper {
  static final Databasehelper _instance = Databasehelper._internal();
  static Database? _database;
  factory Databasehelper() {
    return _instance;
  }
  Databasehelper._internal();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'if.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS estudiante(id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, matricula TEXT)');
        await db.execute;
    

  await db.execute('''
    CREATE TABLE IF NOT EXISTS disciplina(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nombre TEXT,
      professor TEXT
    )
  ''');

  await db.execute('''
    CREATE TABLE IF NOT EXISTS cursando(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      estudiante_id INTEGER,
      disciplina_id INTEGER
    )
  ''');
}
  }



