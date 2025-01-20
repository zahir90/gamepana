// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pana/screens/home_screen.dart';
import 'package:pana/level/level_1.dart';
import 'package:pana/level/level_2.dart';
import 'package:pana/level/level_3.dart';

class LevelSelectScreen extends StatelessWidget {

  const LevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
                  text: 'Pilih Level',
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
            SizedBox(height: screenHeight * 0.04),

            // Tombol Level 1
            levelWithImages(
              context,
              'Level 1',
              'assets/image/1.png',
              'assets/image/4.png',
              const Level1Screen(),
              true,
            ),

            SizedBox(height: screenHeight * 0.04),

            // Tombol Level 2
            levelWithImages(
              context,
              'Level 2',
              'assets/image/2.png',
              'assets/image/5.png',
              const Level2Screen(),
              true,
            ),

            SizedBox(height: screenHeight * 0.04),

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
  return Stack(
    alignment: Alignment.center,
    children: [
      // Latar belakang tombol
      Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
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
            minimumSize: Size(screenWidth * 0.2, screenHeight * 0.14),
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
            ),
          ),
          child: Text(
            isUnlocked ? levelText : "Terkunci",
            style: TextStyle(
              fontSize: screenWidth * 0.03,
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
        left: screenWidth * 0.05,
        top: screenHeight * -0.009,
        child: Image.asset(
          leftImage,
          width: screenWidth * 0.09,
          height: screenHeight * 0.17,
          fit: BoxFit.cover,
        ),
      ),

      // Gambar di kanan
      Positioned(
        right: screenWidth * 0.05,
        top: screenHeight * -0.009,
        child: Image.asset(
          rightImage,
          width: screenWidth * 0.09,
          height: screenHeight * 0.17,
          fit: BoxFit.cover,
        ),
      ),
    ],
  );
}
