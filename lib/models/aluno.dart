class Aluno {
  int? id;
  String ra;
  String periodo;
  String curso;

  Aluno({
    this.id,
    required this.ra,
    required this.periodo,
    required this.curso,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ra': ra,
      'periodo': periodo,
      'curso' : curso,
    };
  }

  factory Aluno.fromMap(Map<String, dynamic> map) {
    return Aluno(
      id: map['id'],
      ra: map['ra'],
      periodo: map['periodo'],
      curso: map['curso'],
    );
  }
}
