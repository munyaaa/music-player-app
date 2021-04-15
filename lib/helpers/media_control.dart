import 'package:audioplayers/audioplayers.dart';

class MediaControl {
  static AudioPlayer player = AudioPlayer();

  AudioPlayer get audioPlayer => player;

  static Future<void> playAudio(String url) async {
    await player.play(url);
  }

  static Future<void> pauseAudio() async {
    await player.pause();
  }

  static Future<void> stopAudio() async {
    await player.stop();
  }

  static Future<void> resumeAudio() async {
    await player.resume();
  }

  static Future<void> seekAudio(Duration duration) async {
    await player.seek(duration);
  }
}