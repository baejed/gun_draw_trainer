import 'package:audioplayers/audioplayers.dart';

class AlertPlayer {

  static final _player = AudioPlayer();
  static const _url = 'sounds/gunshot.wav';

  static Future<void> initializePlayer() async {
    await _player.setSource(AssetSource(_url));
    await _player.resume(); // Plays briefly to initialize
    await _player.pause();  // Then pause immediately
  }

  static Future<void> play() async {
    await _player.resume();
  }

}