class InscricaoImage {
  int? id;
  String imagePath;
  String tipo;

  InscricaoImage({
    this.id,
    required this.imagePath,
    required this.tipo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'tipo': tipo,
    };
  }

  factory InscricaoImage.fromMap(Map<String, dynamic> map) {
    return InscricaoImage(
      id: map['id'],
      imagePath: map['imagePath'],
      tipo: map['tipo'],
    );
  }
}
