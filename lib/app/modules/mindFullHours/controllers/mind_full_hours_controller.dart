import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class MindFullHoursController extends GetxController {
  //TODO: Implement MindFullHoursController

  final count = 0.obs;
  final AudioPlayer player = AudioPlayer();
  RxBool isPlaying = true.obs;
  @override
  void onInit() {
    _initAudio();
    super.onInit();
  }

  Future<void> _initAudio() async {
    try {
      // await player.setAndroidAudioAttributes(
      //   const AndroidAudioAttributes(
      //     contentType: AndroidAudioContentType.music,
      //     usage: AndroidAudioUsage.media,
      //     flags: AndroidAudioFlags.none,
      //   ),
      // );
      await player.setUrl(
        'https://kamelion.s3.eu-north-1.amazonaws.com/public/workoutVideos/Cloudy+vs.+Clear+Day+Mindset.mp3',
      );
      await player.setLoopMode(LoopMode.off);
      await player.play();
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
    player.dispose();
    super.onClose();
  }

  void increment() => count.value++;

  void togglePlayPause() {
    isPlaying.value = !(isPlaying.value);

    isPlaying.value ? player.play() : player.pause();
  }

  String formatTime(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return hours > 0 ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
  }

  void seekForward({Duration offset = const Duration(seconds: 5)}) {
    final currentPosition = player.position;
    final newPosition = currentPosition + offset;
    final duration = player.duration;

    if (duration != null && newPosition > duration) {
      player.seek(duration);
    } else {
      player.seek(newPosition);
    }
  }

  void seekBackward({Duration offset = const Duration(seconds: 5)}) {
    final currentPosition = player.position;
    final newPosition = currentPosition - offset;

    player.seek(newPosition < Duration.zero ? Duration.zero : newPosition);
  }
}
