// ignore_for_file: camel_case_types, unnecessary_null_comparison
import 'dart:math';
import 'package:pana/screens/level_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:pana/data/question.dart'; // Mengimpor data soal dari question.dart

class Level2Screen extends StatefulWidget {
  const Level2Screen({super.key});

  @override
  State<Level2Screen> createState() => _Level2ScreenState();
}

class _Level2ScreenState extends State<Level2Screen> {
  int lives = 3;
  int currentQuestionIndex = 0;
  int correctAnswers = 0;

Question generateQuestion() {
  final r = Random();

  // Pilih dua warna utama
  final color1 = Colors.primaries[r.nextInt(Colors.primaries.length)];
  final color2 = Colors.primaries[r.nextInt(Colors.primaries.length)];

  // Secara opsional tambahkan color3
  final color3 = Colors.primaries[r.nextInt(Colors.primaries.length)];

  // Pilihan warna untuk opsi jawaban
  final optionColor1 = Colors.primaries[r.nextInt(Colors.primaries.length)];
  final optionColor2 = Colors.primaries[r.nextInt(Colors.primaries.length)];

  // Blending warna
  final blended1 = Color.alphaBlend(color1.withOpacity(0.5), color2.withOpacity(0.5));
  final correctColor =  color3 != null 
      ? Color.alphaBlend(blended1.withOpacity(0.67), color3.withOpacity(0.33))
      : blended1; // Jika color3 null, gunakan blended1 sebagai jawaban yang benar

  // Opsi jawaban termasuk warna yang benar
  final options = <Color>[optionColor1, optionColor2, correctColor];

  // Acak urutan opsi
  options.shuffle(r);

  return Question(
    color1: color1,
    color2: color2,
    color3: color3, // Bisa null
    options: options,
    correctAnswer: correctColor,
  );
}

  @override
  Widget build(BuildContext context) {
    // final currentQuestion = questionsLevel1[currentQuestionIndex]; // Mengambil soal berdasarkan index
    final currentQuestion = generateQuestion();

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
                  text: 'Level 2',
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
        child: Column(
          children: [
            const SizedBox(height: 50),

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
    if (currentQuestion.color3 != null) ...[
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
      colorCircle(currentQuestion.color3!, size: 150),
    ],
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
    // final currentQuestion = questionsLevel1[currentQuestionIndex]; // Ambil soal saat ini
    if (selectedColor == correctAnswer) {
      // Jawaban benar
      correctAnswers++; // Tambah jawaban benar
      showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent, // Transparan
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent, // Latar belakang transparan
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/image/benar.png', // Gambar untuk jawaban benar
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              const Text(
                "Jawaban Anda benar.",
                style: TextStyle(fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Super Shiny',
                color: Color(0xFFE6D9A2),
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
                  setState(() {
                    if (currentQuestionIndex < questionsLevel2.length - 1) {
                      currentQuestionIndex++; // Lanjut ke soal berikutnya
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
                child: const Text("Lanjut", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Super Shiny'),),
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
          backgroundColor: Colors.transparent, // Transparan
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent, // Latar belakang transparan
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/image/salah.png', // Gambar untuk jawaban salah
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Sayang sekali, jawaban Anda salah.",
                  style: TextStyle(fontSize: 70, 
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
                  child: const Text("Coba Lagi", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Super Shiny',)),
                ),
              ],
            ),
          ),
        ),
      );
      } else {
        // Nyawa habis, tampilkan dialog hasil akhir
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
                  // Tampilkan hasil akhir
                  Text(
                    // ignore: unnecessary_brace_in_string_interps
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
                            // Reset semua variabel untuk memulai ulang
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
