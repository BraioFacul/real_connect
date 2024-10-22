class Aluno {
  int? id;  // O ID do banco de dados (opcional)
  String nome;
  String ra;
  String periodo;
  String sala;
  String contato;
  String apelido;

  Aluno({
    this.id,
    required this.nome,
    required this.ra,
    required this.periodo,
    required this.sala,
    required this.contato,
    required this.apelido,
  });

  // Converter Aluno para Map (para salvar no banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'ra': ra,
      'periodo': periodo,
      'sala': sala,
      'contato': contato,
      'apelido': apelido,
    };
  }

  // Converter Map para Aluno (para carregar do banco de dados)
  factory Aluno.fromMap(Map<String, dynamic> map) {
    return Aluno(
      id: map['id'],
      nome: map['nome'],
      ra: map['ra'],
      periodo: map['periodo'],
      sala: map['sala'],
      contato: map['contato'],
      apelido: map['apelido'],
    );
  }
}
