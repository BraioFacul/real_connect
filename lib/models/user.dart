class User {
  int? id;
  String nome;
  String sobrenome;
  String senha;
  int idade;
  String email;
  DateTime dataNascimento;
  String sexo;
  String endereco;
  String cidade;

  User({
    this.id,
    required this.nome,
    required this.sobrenome,
    required this.senha,
    required this.idade,
    required this.email,
    required this.dataNascimento,
    required this.sexo,
    required this.endereco,
    required this.cidade,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'sobrenome': sobrenome,
      'senha': senha,
      'idade': idade,
      'email': email,
      'data_nascimento': dataNascimento.toIso8601String(),
      'sexo': sexo,
      'endereco': endereco,
      'cidade': cidade,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nome: map['nome'],
      senha: map['senha'],
      sobrenome: map['sobrenome'],
      idade: map['idade'],
      email: map['email'],
      dataNascimento: DateTime.parse(map['data_nascimento']),
      sexo: map['sexo'],
      endereco: map['endereco'],
      cidade: map['cidade'],
    );
  }
}
