// ignore_for_file: camel_case_types
import 'dart:math';

import 'package:pana/screens/level_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:pana/data/question.dart'; // Mengimpor data soal dari question.dart

class Level1Screen extends StatefulWidget {
  const Level1Screen({super.key});

  @override
  State<Level1Screen> createState() => _Level1ScreenState();
}

class _Level1ScreenState extends State<Level1Screen> {
  int lives = 3;
  int currentQuestionIndex = 0;
  int correctAnswers = 0;

  Question generateQuestion() {
    final r = Random();

    final color1 = Colors.primaries[r.nextInt(Colors.primaries.length)];
    final color2 = Colors.primaries[r.nextInt(Colors.primaries.length)];

    final optionColor1 = Colors.primaries[r.nextInt(Colors.primaries.length)];
    final optionColor2 = Colors.primaries[r.nextInt(Colors.primaries.length)];
    final correctColor =
        Color.alphaBlend(color1.withOpacity(0.5), color2.withOpacity(0.5));
    final options = <Color>[optionColor1, optionColor2, correctColor];

    options.shuffle(r);

    return Question(
      color1: color1,
      color2: color2,
      options: options,
      correctAnswer: correctColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // final currentQuestion = questionsLevel1[currentQuestionIndex]; // Mengambil soal berdasarkan index
    final currentQuestion = generateQuestion();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.13),
        child: AppBar(
          leadingWidth: screenWidth * 0.10,
          toolbarHeight: screenHeight * 0.13,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.01),
              RichText(
                text: TextSpan(
                  text: 'Level 1',
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Super Shiny',
                    color: const Color.fromARGB(255, 230, 218, 162),
                    shadows: const [
                      Shadow(
                        offset: Offset(1, 1),
                        color: Colors.black,
                        blurRadius: 2,
                      ),
                      Shadow(
                        offset: Offset(-1, -1),
                        color: Colors.black,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          backgroundColor:
              const Color.fromARGB(255, 98, 78, 136).withOpacity(0.3),
          elevation: 20,
          leading: IconButton(
            iconSize: screenWidth * 0.07,
            icon: Image.asset(
              'assets/image/Back.png',
              width: screenWidth * 0.03,
              height: screenHeight * 0.04,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LevelSelectScreen(),
                ),
              );
            },
          ),
          actions: [
            Row(
              children: List.generate(3, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    Icons.favorite,
                    size: screenWidth * 0.02,
                    color: index < lives ? Colors.red : Colors.grey, // Nyawa aktif/aktif
                  ),
                );
              }),
            ),
            SizedBox(width: screenWidth * 0.005),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE6D9A2), Color(0xFFD25C9F)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.047),

            // Operasi Lingkaran Warna
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      colorCircle(currentQuestion.color1, size: screenWidth * 0.07),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                        child: Text(
                          "+",
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontFamily: 'Super Shiny',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      colorCircle(currentQuestion.color2, size: screenWidth * 0.07),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                        child: Text(
                          "=",
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontFamily: 'Super Shiny',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      colorCircle(
                        Colors.white,
                        size: screenWidth * 0.07,
                        child: Text(
                          "?",
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontFamily: 'Super Shiny',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.075),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: currentQuestion.options
                        .map((color) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                              child: hoverableColorCircle(color, currentQuestion.correctAnswer, context, size: screenWidth * 0.067),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget colorCircle(Color color, {Widget? child, VoidCallback? onTap, double size = 100}) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(color: Colors.black, width: screenWidth * 0.002),
        ),
        child: Center(
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget hoverableColorCircle(Color color, Color correctColor, BuildContext context, {double size = 100}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(screenWidth * 0.0104),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/image/yakin.png',
                    width: screenWidth * 0.208,
                    height: screenHeight * 0.37,
                  ),
                  SizedBox(height: screenHeight * 0.018),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE6D9A2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.052, vertical: screenHeight * 0.028),
                        ),
                        child: Text("Tidak", style: TextStyle(fontSize: screenWidth * 0.015, fontWeight: FontWeight.bold, fontFamily: 'Super Shiny')),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          checkAnswer(context, color, correctColor);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE6D9A2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.052, vertical: screenHeight * 0.028),
                        ),
                        child: Text("Ya", style: TextStyle(fontSize: screenWidth * 0.015, fontWeight: FontWeight.bold, fontFamily: 'Super Shiny')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(color: Colors.black, width: screenWidth * 0.002),
        ),
      ),
    );
  }

  void checkAnswer(BuildContext context, Color selectedColor, Color correctAnswer) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (selectedColor == correctAnswer) {
      correctAnswers++;
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(screenWidth * 0.0104),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/image/benar.png',
                  width: screenWidth * 0.0104,
                  height: screenHeight * 0.189,
                ),
                SizedBox(height: screenHeight * 0.189),
                Text(
                  "Jawaban Anda benar.",
                  style: TextStyle(
                    fontSize: screenWidth * 0.015,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Super Shiny',
                    color: const Color(0xFFE6D9A2),
                    shadows: const [
                      Shadow(
                        offset: Offset(1, 1),
                        color: Colors.black,
                        blurRadius: 2,
                      ),
                      Shadow(
                        offset: Offset(-1, -1),
                        color: Colors.black,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.189),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      if (currentQuestionIndex < questionsLevel1.length - 1) {
                        currentQuestionIndex++;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE6D9A2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
                  ),
                  child: const Text("Lanjut", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Super Shiny')),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      setState(() {
        lives--;
      });

      if (lives > 0) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/image/salah.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Sayang sekali, jawaban Anda salah.",
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE6D9A2),
                      fontFamily: 'Super Shiny',
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          color: Colors.black,
                          blurRadius: 2,
                        ),
                        Shadow(
                          offset: Offset(-1, -1),
                          color: Colors.black,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE6D9A2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
                    ),
                    child: const Text("Coba Lagi", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Super Shiny')),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Nyawa Anda habis.",
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Super Shiny',
                      color: Color(0xFFE6D9A2),
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          color: Colors.black,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Soal Terjawab Benar: $correctAnswers\n",
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Super Shiny',
                      color: Color(0xFFE6D9A2),
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          color: Colors.black,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            lives = 3;
                            currentQuestionIndex = 0;
                            correctAnswers = 0;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE6D9A2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
                        ),
                        child: const Text(
                          "Coba Lagi dari Awal",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Super Shiny'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LevelSelectScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE6D9A2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
                        ),
                        child: const Text(
                          "Ke Pilih Level",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Super Shiny'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
  }
}
