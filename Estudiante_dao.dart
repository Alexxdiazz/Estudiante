import 'package:crud/DataBaseHelper.dart';
import 'package:crud/estudiante.dart';
import 'package:sqflite/sqflite.dart';

class EstudianteDao {
  final Databasehelper _dbHelper = Databasehelper();

  Future<void> incluirEstudiante(Estudiante e) async {
    final db = await _dbHelper.database;

    print("Insertando ${e.nombre}");

    await db.insert(
      "estudiante",
      e.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Editar no banco
  Future<void> editarEstudiante(Estudiante e) async {
    final db = await _dbHelper.database;
    await db.update(
      "estudiante",
      e.toMap(),
      where: "id = ?",
      whereArgs: [e.id],
    );
  }

  //excluir
  Future<void> deleteEstudiante(int index) async {
    final db = await _dbHelper.database;
    await db.delete(
      "estudiante",
      where: "id = ?",
      whereArgs: [index],
    );
  }

  Future<List<Estudiante>> listarEstudiantes() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query("estudiante");
    return List.generate(maps.length, (index) {
      return Estudiante.fromMap(maps[index]);
    });
  }
}