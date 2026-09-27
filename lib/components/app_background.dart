import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF082D3A),
            Color(0xFF0B1028),
            Color(0xFF180B2F),
          ],
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: -110,
            right: -90,
            child: _GlowBall(color: Color(0x9958F2D6), size: 250),
          ),
          const Positioned(
            top: 170,
            left: -130,
            child: _GlowBall(color: Color(0x66FF5D8F), size: 290),
          ),
          const Positioned(
            top: 430,
            right: -110,
            child: _GlowBall(color: Color(0x5578A8FF), size: 240),
          ),
          const Positioned(
            bottom: -100,
            right: -80,
            child: _GlowBall(color: Color(0x66FFC857), size: 280),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(painter: _GridPainter()),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _GlowBall extends StatelessWidget {
  const _GlowBall({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, Colors.transparent],
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.018)
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 28) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
