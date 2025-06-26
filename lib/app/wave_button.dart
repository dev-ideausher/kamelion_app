import 'dart:math';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/hexColorToFlutterColor.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

class WaveSemiCircleButton extends StatefulWidget {
  final double size;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const WaveSemiCircleButton({
    Key? key,
    this.size = 60,
    this.icon = Icons.favorite,
    this.color = Colors.green,
    required this.onTap,
  }) : super(key: key);

  @override
  State<WaveSemiCircleButton> createState() => _WaveButtonState();
}

class _WaveButtonState extends State<WaveSemiCircleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(); // Continuous ripple, remove `.repeat()` for one-time
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildWave(double size, double opacity) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = 0.5 + (_controller.value * 2);
        final fade = (1 - _controller.value).clamp(0.0, 1.0) * opacity;

        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: fade,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.brandColor1,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: widget.size * 3,
        height: widget.size * 3,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildWave(widget.size * 1.5, 0.3),
            _buildWave(widget.size * 2.0, 0.2),
            _buildWave(widget.size * 2.5, 0.1),
            InkWell(
              onTap: widget.onTap,
              child: Stack(
                children: [
                  MyArc(),
                  Container(
                    // width: widget.size,
                    // height: widget.size,
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    // color: context.brandColor1,
                    // ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.ksp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hold for\nSupport",
                            style: TextStyleUtil.genSans500(
                              fontSize: 12.ksp,
                            ).copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyArc extends StatelessWidget {
  final double diameter;

  const MyArc({super.key, this.diameter = 200});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: MyPainter(), size: Size(diameter, diameter));
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = HexColor("#238E5B");
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
