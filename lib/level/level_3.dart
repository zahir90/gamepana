// ignore_for_file: camel_case_types
import 'dart:math';
import 'dart:async';
import 'package:pana/screens/level_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:pana/data/question.dart'; // Mengimpor data soal dari question.dart
import 'package:flutter_randomcolor/flutter_randomcolor.dart';

class Level3Screen extends StatefulWidget {
  const Level3Screen({super.key});

  @override
  State<Level3Screen> createState() => _Level3ScreenState();
}

class _Level3ScreenState extends State<Level3Screen> {
  int lives = 3;
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  late Question currentQuestion;
  int timerDuration = 10; // Durasi waktu per soal (dalam detik)
  late int timeLeft; // Waktu tersisa
  Timer? timer; // Objek Timer
  bool isColorGenerated = true;
  bool _isTimerRunning = false; // Menandakan apakah timer sedang berjalan

Question generateQuestion() {
  final generateRandomColor = RandomColor.getColorObject(Options());
  final r = Random();

  // Generate colors using RandomColor
  final color1 = RandomColor.getColorObject(Options());
  final color2 = RandomColor.getColorObject(Options());

  // Option colors for answer choices
  final optionColor1 = generateRandomColor;
  final optionColor2 = Colors.primaries[r.nextInt(Colors.primaries.length)];
  final correctColor = Color.alphaBlend(color1.withOpacity(0.5), color2.withOpacity(0.5));

  // Shuffle options
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
void initState() {
  super.initState();
  timeLeft = timerDuration;
  currentQuestion = generateQuestion();
  startTimer();
}

void startTimer() {
  timer?.cancel(); // Hentikan timer sebelumnya jika ada
  timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    if (timeLeft > 0) {
      setState(() {
        timeLeft--;
      });
    } else {
      timer.cancel();
      showTimeOutDialog(); // Tampilkan dialog waktu habis
    }
  });
}

void resetGame() {
  setState(() {
    lives = 3;
    correctAnswers = 0;
    timeLeft = timerDuration;
    currentQuestion = generateQuestion(); // Soal baru
  });
  startTimer(); // Mulai timer ulang
}

void resetTimer() {
  timeLeft = timerDuration;
}


@override
void dispose() {
  timer?.cancel();
  super.dispose();
}

// Fungsi untuk menjeda timer
void pauseTimer() {
  timer?.cancel();
  setState(() {
    _isTimerRunning = false; // Tandai timer dihentikan
  });
}

// Fungsi untuk melanjutkan timer
void resumeTimer() {
  if (!_isTimerRunning) {
    startTimer(); // Lanjutkan timer
  }
}

  @override
  Widget build(BuildContext context) {
    // final currentQuestion = questionsLevel1[currentQuestionIndex]; // Mengambil soal berdasarkan index
      // final currentQuestion = generateQuestion();
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140.0),
        child: AppBar(
          leadingWidth: 200,
          toolbarHeight: 140,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  text: 'Level 3',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Super Shiny',
                    color: Color.fromARGB(255, 230, 218, 162),
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
                ),
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 98, 78, 136).withOpacity(0.3),
          elevation: 20,
          leading: IconButton(
            iconSize: 140,
            icon: Image.asset(
              'assets/image/Back.png',
              width: 70,
              height: 50,
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
                    size: 40,
                    color: index < lives ? Colors.red : Colors.grey, // Nyawa aktif/aktif
                  ),
                );
              }),
            ),
            const SizedBox(width: 10),
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
        child:
        
         Column(
          children: [
            const SizedBox(height: 50),
Column(
  children: [
    Text(
      "Waktu: $timeLeft",
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    const SizedBox(height: 20),
  ],
),

            // Operasi Lingkaran Warna
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      colorCircle(currentQuestion.color1, size: 150),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "+",
                          style: TextStyle(
                            fontSize: 120,
                            fontFamily: 'Super Shiny',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      colorCircle(currentQuestion.color2, size: 150),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "=",
                          style: TextStyle(
                            fontSize: 120,
                            fontFamily: 'Super Shiny',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      colorCircle(
                        Colors.white,
                        size: 150,
                        child: const Text(
                          "?",
                          style: TextStyle(
                            fontSize: 120,
                            fontFamily: 'Super Shiny',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: currentQuestion.options
                        .map((color) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: hoverableColorCircle(color, currentQuestion.correctAnswer, context, size: 130),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(color: Colors.black, width: 4),
        ),
        child: Center(
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    );
    
  }

Widget hoverableColorCircle(Color color, Color correctColor, BuildContext context, {double size = 100}) {
  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent, // Latar belakang dialog transparan
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent, // Latar belakang semi transparan
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/image/yakin.png', // Ganti dengan path gambar yang sesuai
                width: 400,
                height: 400,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Tutup pop-up
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE6D9A2), // Warna tombol
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
                      ),
                      child: const Text("Tidak", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Super Shiny',)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Tutup pop-up
                        checkAnswer(context, color, correctColor); // Konfirmasi jawaban
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE6D9A2), // Warna tombol
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                       padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
                      ),
                      child: const Text("Ya", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Super Shiny',)),
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
          border: Border.all(color: Colors.black, width: 4),
        ),
      ),
    );
  }

void checkAnswer(BuildContext context, Color selectedColor, Color correctAnswer) {
  // Cek jawaban yang dipilih
  if (selectedColor == currentQuestion.correctAnswer) {
    setState(() {
      correctAnswers++;
      currentQuestion = generateQuestion(); // Soal baru
      pauseTimer();
    });
    // Tampilkan dialog jawaban benar
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
                'assets/image/benar.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              const Text(
                "Jawaban Anda benar.",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Super Shiny',
                  color: Color(0xFFE6D9A2),
                  shadows: [
                    Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 2),
                    Shadow(offset: Offset(-1, -1), color: Colors.black, blurRadius: 2),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  resumeTimer();
                  resetTimer();
                  setState(() {
                    currentQuestionIndex++;
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
                  "Lanjut",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Super Shiny',
                  ),
                ),
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
      // Tampilkan dialog jawaban salah hanya jika lives masih ada
      currentQuestion = generateQuestion(); // Soal baru
      pauseTimer();
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
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Super Shiny',
                    color: Color(0xFFE6D9A2),
                    shadows: [
                      Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 2),
                      Shadow(offset: Offset(-1, -1), color: Colors.black, blurRadius: 2),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  resumeTimer();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE6D9A2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
                  ),
                  child: const Text(
                    "Coba Lagi",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Super Shiny',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // Nyawa habis, tampilkan dialog hasil akhir
      timer?.cancel();
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
                Text(
                  "Nyawa Anda habis.\nSoal Terjawab Benar: $correctAnswers", // Tampilkan jumlah jawaban benar
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
                      resetGame(); // Reset permainan
                      lives = 3;
                      correctAnswers = 0;
                      currentQuestionIndex = 0;
                      startTimer();
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
                    "Coba Lagi",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Super Shiny',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                    "Pilih Level",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Super Shiny'),
                  ),
                ),
              ],
            ),
          ],),
        ),
      ));
    }
  }
}



  void showTimeOutDialog() {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent, // Latar belakang transparan
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Waktu Habis!",
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
            // Tampilkan statistik soal
            Text(

              "Jawaban benar: $correctAnswers\n",
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
                      // Reset semua variabel
                      lives = 3;
                      currentQuestionIndex = 0;
                      correctAnswers = 0;
                      timeLeft = 30;
                    });
                    startTimer(); // Mulai ulang timer
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
                      Navigator.push(
                          context,
                           MaterialPageRoute(
                              builder: (context) =>const LevelSelectScreen(), // Ganti 5 dengan nilai dinamis
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
                    "Pilih Level",
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