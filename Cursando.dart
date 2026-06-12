class Cursando {
  int? id;
  int estudianteId;
  int disciplinaId;

  Cursando({
    this.id,
    required this.estudianteId,
    required this.disciplinaId,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "estudiante_id": estudianteId,
      "disciplina_id": disciplinaId,
    };
  }

  factory Cursando.fromMap(Map<String, dynamic> map) {
    return Cursando(
      id: map['id'],
      estudianteId: map['estudiante_id'],
      disciplinaId: map['disciplina_id'],
    );
  }
}