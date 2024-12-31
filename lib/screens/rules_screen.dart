import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: PreferredSize(
  preferredSize: const Size.fromHeight(140.0), // Tinggi AppBar
  child: AppBar(
    leadingWidth: 200,
    toolbarHeight: 140,
    flexibleSpace: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20), // Jarak dengan atas
        RichText(
          text: const TextSpan(
            text: 'Aturan Permainan',
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
      iconSize: 140, // Ukuran ikon
      icon: 
      // ImageIcon(
      //   AssetImage('image/Back.svg'),
      //   size: 140,
      // ),
      Image.asset(
        fit: BoxFit.cover,
        scale: 5,
        'assets/image/Back.png', // Ganti dengan path gambar yang Anda inginkan
        width: 70, // Ukuran gambar
        height: 50, // Ukuran gambar
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
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(70, 137, 103, 179),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 80, bottom: 80, left: 40, right: 40),
                decoration: BoxDecoration(
                  color: const Color(0xFF8967B3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• Dalam permainan ini ada 3 level, setiap level akan ada soal yang diberikan.',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Super Shiny',
                        color: Color.fromARGB(255, 230, 218, 162),
                        shadows: [
                          Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 2),
                          Shadow(offset: Offset(-1, -1), color: Colors.black, blurRadius: 2),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '• Permainan ini akan dibekali 3 nyawa, dan setiap salah menebak akan berkurang satu.',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Super Shiny',
                        color: Color.fromARGB(255, 230, 218, 162),
                        shadows: [
                          Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 2),
                          Shadow(offset: Offset(-1, -1), color: Colors.black, blurRadius: 2),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '• Soal di setiap akhir level adalah raja warna. Kalahkan raja warna untuk bisa ke level selanjutnya.',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Super Shiny',
                        color: Color.fromARGB(255, 230, 218, 162),
                        shadows: [
                          Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 2),
                          Shadow(offset: Offset(-1, -1), color: Colors.black, blurRadius: 2),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '• Selamat belajar sambil bermain!!!!',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Super Shiny',
                        color: Color.fromARGB(255, 230, 218, 162),
                        shadows: [
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
