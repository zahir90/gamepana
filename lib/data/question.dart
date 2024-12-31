import 'package:flutter/material.dart';

class Question {
  final Color color1;
  final Color color2;
  final Color? color3; // Tambahkan color3 dengan tipe nullable
  final List<Color> options;
  final Color correctAnswer;

  Question({
    required this.color1,
    required this.color2,
    this.color3, // Tambahkan di konstruktor
    required this.options,
    required this.correctAnswer,
  });
}


// Daftar soal untuk level 1
final List<Question> questionsLevel1 = [
];

final List<Question> questionsLevel2 = [
];

final List<Question> questionsLevel3 = [
];