import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'audio_service.dart';

void main() {
  runApp(const PanaGame());
}

class PanaGame extends StatelessWidget {
   const PanaGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PANA Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class MyAppState extends State {
  final AudioService _audioService = AudioService();

  @override
  void initState() {
    super.initState();
    _audioService.playBackgroundMusic();
  }

  @override
  void dispose() {
    _audioService.stopBackgroundMusic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
