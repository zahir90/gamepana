import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
  appBar: PreferredSize(
  preferredSize: const Size.fromHeight(140.0), // Tinggi AppBar
  child: AppBar(
    leadingWidth: screenWidth * 0.10,
    toolbarHeight: screenHeight * 0.13,
    flexibleSpace: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: screenHeight * 0.01), // Jarak dengan atas
        RichText(
          text: TextSpan(
            text: 'Aturan Permainan',
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
    backgroundColor: const Color.fromARGB(255, 98, 78, 136).withOpacity(0.3),
    elevation: 20,
        leading: IconButton(
      iconSize: screenWidth * 0.07,
      icon: 
      // ImageIcon(
      //   AssetImage('image/Back.svg'),
      //   size: 140,
      // ),
      Image.asset(
        fit: BoxFit.cover,
        scale: 5,
        'assets/image/Back.png', // Ganti dengan path gambar yang Anda inginkan
        width: screenWidth * 0.03,
        height: screenHeight * 0.04,
      ),
      onPressed: () {
        Navigator.pop(context);
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
  image: DecorationImage(
    image: AssetImage('assets/image/background_rule.png'),
    fit: BoxFit.cover,
  ),
),

        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: screenWidth * 0.52),
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.01),
              decoration: BoxDecoration(
                color: const Color.fromARGB(70, 137, 103, 179),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                padding: EdgeInsets.only(top: screenHeight * 0.07, bottom: screenHeight * 0.07, left: screenWidth * 0.02, right: screenWidth * 0.02),
                decoration: BoxDecoration(
                  color: const Color(0xFF8967B3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• Dalam permainan ini ada 3 level, setiap level akan ada soal yang diberikan.',
                      style: TextStyle(
                        fontSize: screenWidth * 0.02,
                        fontFamily: 'Super Shiny',
                        color: const Color.fromARGB(255, 230, 218, 162),
                        shadows: const [
                          Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 2),
                          Shadow(offset: Offset(-1, -1), color: Colors.black, blurRadius: 2),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.009),
                    Text(
                      '• Permainan ini akan dibekali 3 nyawa, dan setiap salah menebak akan berkurang satu.',
                      style: TextStyle(
                        fontSize: screenWidth * 0.02,
                        fontFamily: 'Super Shiny',
                        color: const Color.fromARGB(255, 230, 218, 162),
                        shadows: const [
                          Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 2),
                          Shadow(offset: Offset(-1, -1), color: Colors.black, blurRadius: 2),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.009),
                    Text(
                      '• Soal di setiap akhir level adalah raja warna. Kalahkan raja warna untuk bisa ke level selanjutnya.',
                      style: TextStyle(
                        fontSize: screenWidth * 0.02,
                        fontFamily: 'Super Shiny',
                        color: const Color.fromARGB(255, 230, 218, 162),
                        shadows: const [
                          Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 2),
                          Shadow(offset: Offset(-1, -1), color: Colors.black, blurRadius: 2),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.009),
                    Text(
                      '• Selamat belajar sambil bermain!!!!',
                      style: TextStyle(
                        fontSize: screenWidth * 0.02,
                        fontFamily: 'Super Shiny',
                        color: const Color.fromARGB(255, 230, 218, 162),
                        shadows: const [
                          Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 2),
                          Shadow(offset: Offset(-1, -1), color: Colors.black, blurRadius: 2),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
