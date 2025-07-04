import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/services/colors.dart';

import 'package:kamelion/app/wave_button.dart';

import '../../../services/breathe_wave.dart';
import '../controllers/mind_full_hours_controller.dart';

class MindFullHoursView extends GetView<MindFullHoursController> {
  MindFullHoursView({super.key});

  MindFullHoursController controller = Get.put(MindFullHoursController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('MindFullHoursView'), centerTitle: true),
      body: BreathingScreen(),
    );
  }
}

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> {
  bool isPlaying = true;
  bool isInhale = true;
  double currentTime = 321; // 5:21
  double totalTime = 1500; // 25:00
  MindFullHoursController controller = Get.put(MindFullHoursController());
  @override
  Widget build(BuildContext context) {
    final bgColor = isInhale
        ? const Color(0xFF4CAF50)
        : const Color(0xFFEF5350); // green / red
    final text = isInhale ? 'Breathe In...' : 'Breathe Out...';
    final icon = isPlaying ? Icons.pause : Icons.play_arrow;

    return Scaffold(
      backgroundColor: context.brandColor1,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.surround_sound, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Sound: Mindful hours',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Breathing animation placeholder
            Stack(
              children: [
                Obx(
                  () => WaveBreathingButton(
                    isPlaying: controller.isPlaying.value,
                    onTap: () {},
                  ),
                )
                // Center(
                //   child: Container(
                //     width: 200,
                //     height: 200,
                //     decoration: const BoxDecoration(
                //       shape: BoxShape.circle,
                //       gradient: RadialGradient(
                //         colors: [Colors.black12, Colors.transparent],
                //         stops: [0.0, 1.0],
                //       ),
                //     ),
                //     alignment: Alignment.center,
                //     child: Text(
                //       text,
                //       style: const TextStyle(
                //         color: Colors.white,
                //         fontSize: 24,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            const Spacer(),
            // Progress bar
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: StreamBuilder<Duration>(
                stream: controller.player.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  final total = controller.player.duration ?? Duration.zero;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${controller.formatTime(position)}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      // Text("Current: ${controller.formatTime(position)}"),
                      // Text("Total: ${controller.formatTime(total)}"),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            thumbShape: SliderComponentShape
                                .noThumb, // 👈 hides the circle
                          ),
                          child: Slider(
                            min: 0,
                            activeColor: Colors.white,
                            inactiveColor: Colors.white30,
                            max: total.inMilliseconds.toDouble(),
                            value: position.inMilliseconds
                                .clamp(0, total.inMilliseconds)
                                .toDouble(),
                            onChanged: (value) {
                              // controller.player
                              //     .seek(Duration(milliseconds: value.toInt()));
                            },
                          ),
                        ),
                      ),
                      Text(
                        "${controller.formatTime(total)}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  );
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Row(
            //     children: [
            //       Text(
            //         _formatTime(currentTime),
            //         style: const TextStyle(color: Colors.white),
            //       ),
            //       Expanded(
            //         child: Slider(
            //           value: currentTime,
            //           min: 0,
            //           max: totalTime,
            //           onChanged: (value) {
            //             setState(() => currentTime = value);
            //           },
            //           activeColor: Colors.white,
            //           inactiveColor: Colors.white30,
            //         ),
            //       ),
            //       Text(
            //         _formatTime(totalTime),
            //         style: const TextStyle(color: Colors.white),
            //       ),
            //     ],
            //   ),
            // ),

            const SizedBox(height: 10),
            // Control buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.replay,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      controller.seekBackward();
                    },
                  ),
                  Obx(
                    () => FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        controller.togglePlayPause();
                      },
                      child: Icon(
                          controller.isPlaying.value
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: bgColor),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      controller.seekForward();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  String _formatTime(double timeInSeconds) {
    final minutes = (timeInSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (timeInSeconds % 60).toInt().toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
