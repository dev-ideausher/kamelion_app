import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class MindFullHoursController extends GetxController {
  //TODO: Implement MindFullHoursController

  final count = 0.obs;
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = true;
  @override
  void onInit() {
    _initAudio();
    super.onInit();
  }

  Future<void> _initAudio() async {
    try {
      await _player.setUrl(
        'https://kamelion.s3.eu-north-1.amazonaws.com/public/workoutVideos/Cloudy+vs.+Clear+Day+Mindset.mp3',
      );
      await _player.setLoopMode(LoopMode.off);
      await _player.play();
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  @override
  void onReady() {
    // _initAudio();
    super.onReady();
  }

  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }

  void increment() => count.value++;

  void togglePlayPause() {
    isPlaying = !isPlaying;

    isPlaying ? _player.play() : _player.pause();
  }
}
