import 'package:flutter/material.dart';
import 'package:bmicalc/constants.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.onLongPressed,
    this.size = 48.0,
    this.color = const Color(0xFF252D47),
    this.elevation = 0.0,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;
  final VoidCallback? onLongPressed;
  final double size;
  final Color color;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withValues(alpha: 0.98), const Color(0xFF141A2C)],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x80000000),
            blurRadius: 14,
            offset: Offset(0, 8),
          ),
          BoxShadow(
            color: Color(0x1FFFFFFF),
            blurRadius: 7,
            offset: Offset(-3, -3),
          ),
        ],
      ),
      child: RawMaterialButton(
        elevation: elevation,
        onPressed: onPressed,
        onLongPress: onLongPressed,
        constraints: BoxConstraints.tightFor(width: size, height: size),
        shape: const CircleBorder(),
        fillColor: Colors.transparent,
        child: Icon(icon, color: kAccentColorAlt, size: 18),
      ),
    );
  }
}
