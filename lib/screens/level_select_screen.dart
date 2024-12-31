import 'package:flutter/material.dart';
import 'package:pana/screens/home_screen.dart';
import 'package:pana/level/level_1.dart';
import 'package:pana/level/level_2.dart';
import 'package:pana/level/level_3.dart';

class LevelSelectScreen extends StatelessWidget {

  const LevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  text: 'Pilih Level',
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
          backgroundColor:
              const Color.fromARGB(255, 98, 78, 136).withOpacity(0.3),
          elevation: 20,
          leading: IconButton(
            iconSize: 140,
            icon: Image.asset(
              'assets/image/Back.png',
              width: 70,
              height: 50,
            ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
          ),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),

            // Tombol Level 1
            levelWithImages(
              context,
              'Level 1',
              'assets/image/1.png',
              'assets/image/4.png',
              const Level1Screen(),
              true,
            ),

            const SizedBox(height: 50),

            // Tombol Level 2
            levelWithImages(
              context,
              'Level 2',
              'assets/image/2.png',
              'assets/image/5.png',
              const Level2Screen(),
              true,
            ),

            const SizedBox(height: 50),

            // Tombol Level 3
            levelWithImages(
              context,
              'Level 3',
              'assets/image/3.png',
              'assets/image/6.png',
              const Level3Screen(),
              true,
            ),
          ],
        ),
      ),
    );
  }
}

Widget levelWithImages(
    BuildContext context,
    String levelText,
    String leftImage,
    String rightImage,
    Widget? targetScreen,
    bool isUnlocked) {
  return Stack(
    alignment: Alignment.center,
    children: [
      // Latar belakang tombol
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 100),
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: ElevatedButton(
          onPressed: isUnlocked
              ? () {
                  // Navigasi ke halaman target jika level terbuka
                  if (targetScreen != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => targetScreen),
                    );
                  }
                }
              : null, // Jika level terkunci, tombol dinonaktifkan
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE6D9A2),
            minimumSize: const Size(560, 150),
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
            ),
          ),
          child: Text(
            isUnlocked ? levelText : "Terkunci",
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              fontFamily: 'Super Shiny',
              color: isUnlocked
                  ? const Color(0xFF624E88)
                  : const Color(0xFFAAAAAA), // Warna abu-abu jika terkunci
            ),
          ),
        ),
      ),

      // Gambar di kiri
      Positioned(
        left: 100,
        top: -10,
        child: Image.asset(
          leftImage,
          width: 180,
          height: 180,
          fit: BoxFit.cover,
        ),
      ),

      // Gambar di kanan
      Positioned(
        right: 100,
        top: -10,
        child: Image.asset(
          rightImage,
          width: 180,
          height: 180,
          fit: BoxFit.cover,
        ),
      ),
    ],
  );
}
