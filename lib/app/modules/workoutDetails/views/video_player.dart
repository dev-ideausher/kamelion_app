import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
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
    _videoPlayerController = VideoPlayerController.network(
      videoUrl ??
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    );

    await _videoPlayerController.initialize();

    _videoPlayerController.seekTo(const Duration(minutes: 0, seconds: 0));
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      showControls: true,
      allowedScreenSleep: false,
      fullScreenByDefault: true,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.landscapeLeft],
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: (context) {
              _changeSpeed(0.5);
            },
            iconData: Icons.slow_motion_video,
            title: '0.5x',
          ),
          OptionItem(
            onTap: (context) {
              _changeSpeed(1.0);
            },
            iconData: Icons.speed,
            title: '1.0x',
          ),
          OptionItem(
            onTap: (context) {
              _changeSpeed(1.5);
            },
            iconData: Icons.speed_outlined,
            title: '1.5x',
          ),
          OptionItem(
            onTap: (context) {
              _changeSpeed(2.0);
            },
            iconData: Icons.fast_forward,
            title: '2.0x',
          ),
        ];
      },
    );
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        Get.offNamed(
          Routes.ONBOARDING_QUESTIONS,
          arguments: workoutId,
        );
        // print("video ended");
      }
      ;
    });
// _chewieController
    setState(() {});
  }

  void _changeSpeed(double speed) {
    Navigator.pop(context);
    _videoPlayerController.setPlaybackSpeed(speed);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Speed set to ${speed}x')));
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    print(_videoPlayerController.value.position);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.black,
      appBar: AppBar(backgroundColor: context.black),
      body: _chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized
          ? Chewie(controller: _chewieController!)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
