import 'dart:ui';
import 'package:flutter/material.dart';

class Materia {
  String nome;
  String situacao;
  double media;
  IconData icon;
  Color cardColor;

  Materia({
    required this.nome,
    required this.situacao,
    required this.media,
    required this.icon,
    required this.cardColor,
  });

  // Método para criar uma instância de Materia a partir de um Map (json)
  factory Materia.fromMap(Map<String, dynamic> map) {
    return Materia(
      nome: map['nome'],
      situacao: map['situacao'],
      media: map['media'],
      icon: map['icon'],
      cardColor: Color(map['cardColor']),
    );
  }

  // Método para converter a instância em um Map (json)
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'situacao': situacao,
      'media': media,
      'icon': icon,
      'cardColor': cardColor.value,
    };
  }
}
