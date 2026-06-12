import 'package:crud/Cursando.dart';
import 'package:crud/DataBaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class CursandoDao {
  final Databasehelper _dbHelper = Databasehelper();

  Future<void> incluirCursando(Cursando c) async {
    final db = await _dbHelper.database;

    await db.insert(
      "cursando",
      c.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> editarCursando(Cursando c) async {
    final db = await _dbHelper.database;

    await db.update(
      "cursando",
      c.toMap(),
      where: "id = ?",
      whereArgs: [c.id],
    );
  }

  Future<void> deleteCursando(int index) async {
    final db = await _dbHelper.database;

    await db.delete(
      "cursando",
      where: "id = ?",
      whereArgs: [index],
    );
  }

  Future<List<Cursando>> listarCursando() async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps =
        await db.query("cursando");

    return List.generate(maps.length, (index) {
      return Cursando.fromMap(maps[index]);
    });
  }

  Future<List<Map<String, dynamic>>> listarComJoin() async {
    final db = await _dbHelper.database;

    return await db.rawQuery('''
      SELECT
        c.id,
        c.estudiante_id,
        c.disciplina_id,
        e.nombre as estudiante,
        d.nombre as disciplina
      FROM cursando c
      INNER JOIN estudiante e
        ON c.estudiante_id = e.id
      INNER JOIN disciplina d
        ON c.disciplina_id = d.id
    ''');
  }
}
