import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/routes/app_pages.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  String? videoUrl;
  String? workoutId;

  @override
  void initState() {
    super.initState();
    videoUrl = Get.arguments['videoUrl'];
    workoutId = Get.arguments['workoutId'];
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl ?? ""),
    );
    await _videoPlayerController.initialize();
    await _videoPlayerController.seekTo(Duration.zero);
    _videoPlayerController.play();
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        Get.offNamed(
          Routes.ONBOARDING_QUESTIONS,
          arguments: workoutId,
        );
        // print("video ended");
      }
      setState(() {}); // Update UI for progress bar
    });
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  String formatDuration(Duration duration) {
    return DateFormat.ms().format(DateTime(0).add(duration));
  }

  @override
  Widget build(BuildContext context) {
    if (_videoPlayerController.value.hasError) {
      return Scaffold(
        backgroundColor: context.black,
        appBar: AppBar(backgroundColor: context.black),
        body: Center(
          child: Text(
            'Video error: \\${_videoPlayerController.value.errorDescription}',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: context.black,
      appBar: AppBar(backgroundColor: context.black),
      body: _videoPlayerController.value.isInitialized
          ? Stack(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        VideoPlayer(_videoPlayerController),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_videoPlayerController.value.isPlaying) {
                                    _videoPlayerController.pause();
                                  } else {
                                    _videoPlayerController.play();
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Icon(
                                  _videoPlayerController.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 48,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 16,
                  right: 16,
                  child: _buildProgressBar(),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildProgressBar() {
    final value = _videoPlayerController.value;
    final position = value.position;
    final duration = value.duration;

    if (duration.inMilliseconds <= 0 || duration.inMilliseconds.isNaN) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            min: 0.0,
            max: 1.0,
            value: 0.0,
            onChanged: null, // disabled
            activeColor: Colors.white,
            inactiveColor: Colors.white30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('00:00', style: const TextStyle(color: Colors.white)),
              Text('00:00', style: const TextStyle(color: Colors.white)),
            ],
          ),
        ],
      );
    }

    double sliderValue = position.inMilliseconds.toDouble();
    double sliderMax = duration.inMilliseconds.toDouble();
    if (sliderValue < 0) sliderValue = 0.0;
    if (sliderValue > sliderMax) sliderValue = sliderMax;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slider(
          min: 0.0,
          max: sliderMax,
          value: sliderValue.isNaN ? 0.0 : sliderValue,
          onChanged: (value) {
            _videoPlayerController
                .seekTo(Duration(milliseconds: value.toInt()));
          },
          activeColor: Colors.white,
          inactiveColor: Colors.white30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(formatDuration(position),
                style: const TextStyle(color: Colors.white)),
            Text(formatDuration(duration),
                style: const TextStyle(color: Colors.white)),
          ],
        ),
      ],
    );
  }
}
