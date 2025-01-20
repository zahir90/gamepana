import 'package:flutter/material.dart';
import '../audio_service.dart';
import 'rules_screen.dart';
import 'level_select_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioService _audioService = AudioService();
  bool isMusicPlaying = true;

  @override
  void initState() {
    super.initState();
    _audioService.playBackgroundMusic(); // Mulai musik saat layar dimuat
  }

  @override
  void dispose() {
    _audioService.stopBackgroundMusic(); // Hentikan musik saat layar ditutup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE6D9A2), Color(0xFFD25C9F)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // Gambar latar belakang horizontal
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Tombol suara di pojok kanan atas
            Positioned(
              top: 80,
              right: 120,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE6D9A2), Color(0xFFD25C9F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(55),
                ),
                padding: const EdgeInsets.all(20),
                child: IconButton(
                  iconSize: 70,
                  icon: Image.asset(
                    isMusicPlaying
                        ? 'assets/image/Speaker.png' // Ikon saat musik menyala
                        : 'assets/image/Speaker-off.png', // Ikon saat musik mati
                    width: screenWidth * 0.03,
                    height: screenHeight * 0.06,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isMusicPlaying) {
                        _audioService.stopBackgroundMusic();
                      } else {
                        _audioService.resumeBackgroundMusic();
                      }
                      isMusicPlaying = !isMusicPlaying; // Toggle status musik
                    });
                  },
                ),
              ),
            ),

            // Konten utama
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Teks dengan Gradien
                  Column(
                    children: [
                      _buildGradientText('PADU'),

                       SizedBox(height: screenHeight * 0.01),

                      _buildGradientText('WARNA'),
                    ],
                  ),
                   SizedBox(height: screenHeight * 0.03),

                  // Tombol MAINKAN
                  _buildButton(
                    context,
                    label: 'MAINKAN',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LevelSelectScreen(),
                        ),
                      );
                    },
                  ),
                   SizedBox(height: screenHeight * 0.01),

                  // Tombol ATURAN PERMAINAN
                  _buildButton(
                    context,
                    label: 'ATURAN PERMAINAN',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RulesScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientText(String text) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: screenWidth * 0.07,
            fontWeight: FontWeight.bold,
            fontFamily: 'Super Shiny',
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = screenWidth * 0.004
              ..color = const Color(0xFFE6D9A2),
            height: screenHeight * 0.0007,
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF624E88), Color(0xFF191422)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(bounds),
          child: Text(
            text,
            style: TextStyle(
              fontSize: screenWidth * 0.07,
              fontWeight: FontWeight.bold,
              fontFamily: 'Super Shiny',
              color: const Color(0xFF624E88),
              height: screenHeight * 0.0007,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, {required String label, required VoidCallback onPressed}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE6D9A2),
        minimumSize: Size(screenWidth * 0.2, screenHeight * 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: screenWidth * 0.03,
          fontWeight: FontWeight.bold,
          fontFamily: 'Super Shiny',
          color: const Color(0xFF624E88),
          height: screenHeight * 0.0005,
        ),
      ),
    );
  }
}
