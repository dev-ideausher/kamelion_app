import 'package:flutter/material.dart';

class WaveBreathingButton extends StatefulWidget {
  final double size;
  final VoidCallback onTap;

  const WaveBreathingButton({
    Key? key,
    this.size = 200,
    required this.onTap,
  }) : super(key: key);

  @override
  State<WaveBreathingButton> createState() => _WaveBreathingButtonState();
}

class _WaveBreathingButtonState extends State<WaveBreathingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late bool isBreathingIn;

  @override
  void initState() {
    super.initState();
    isBreathingIn = true;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _scaleAnimation = Tween<double>(begin: 1.5, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _startBreathing();
  }

  void _startBreathing() {
    _controller.forward().then((_) {
      setState(() => isBreathingIn = false);
      _controller.reverse().then((_) {
        setState(() => isBreathingIn = true);
        _startBreathing(); // Loop
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildWave(double baseSize, double opacity) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final scale = _scaleAnimation.value;
        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity,
            child: Container(
              width: baseSize,
              height: baseSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF114B39), // match your image's green
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
        width: widget.size * 2,
        height: widget.size * 2,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildWave(widget.size * 1, 0.4),
            _buildWave(widget.size * 1.5, 0.3),
            _buildWave(widget.size * 2.0, 0.2),
            _buildWave(widget.size * 2.5, 0.1),

            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF114B39),
              ),

            ),
            Center(
              child: Text(
                isBreathingIn ? "Breathe In..." : "Breathe Out...",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
