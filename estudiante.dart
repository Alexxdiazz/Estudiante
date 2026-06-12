class Estudiante {
  int? id;
  String nombre;
  String matricula;
  Estudiante({this.id, required this.nombre, required this.matricula});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nombre": nombre,
      "matricula": matricula,
    };
  }

  factory Estudiante.fromMap(Map<String, dynamic> map) {
    return Estudiante(
      id: map['id'],
      nombre: map['nombre'],
      matricula: map['matricula'],
    );
  }
}