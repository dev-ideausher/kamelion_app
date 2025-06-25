import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kamelion/app/services/colors.dart';
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
        final scale = 0 + (_controller.value * 2);
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
              child: Container(
                // width: widget.size,
                // height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.brandColor1,
                ),
                child: Padding(
                  padding: EdgeInsets.all(30.0.ksp),
                  child: Text(
                    "Hold for\nSupport",
                    style: TextStyleUtil.genSans500(fontSize: 12.ksp),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
