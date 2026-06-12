class Disciplina {
  int? id;
  String nombre;
  String profesor;

  Disciplina({
    this.id,
    required this.nombre,
    required this.profesor,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nombre": nombre,
      "profesor": profesor,
    };
  }

  factory Disciplina.fromMap(Map<String, dynamic> map) {
    return Disciplina(
      id: map['id'],
      nombre: map['nombre'],
      profesor: map['profesor'],
    );
  }
}