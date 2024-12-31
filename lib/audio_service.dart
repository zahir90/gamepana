import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  void playBackgroundMusic() {
    _player.setReleaseMode(ReleaseMode.loop); // Musik diputar ulang
    _player.play(AssetSource('audio/background.mp3')); // Path ke file audio
  }

  void pauseBackgroundMusic() {
    _player.pause();
  }

  void resumeBackgroundMusic() {
    _player.resume();
  }

  void stopBackgroundMusic() {
    _player.stop();
  }
}
