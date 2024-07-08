import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.onLongPressed,
    this.size = 56.0,
    this.color = const Color(0xFF4C4F5E),
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
    return RawMaterialButton(
      elevation: elevation,
      onPressed: onPressed,
      onLongPress: onLongPressed ?? onLongPressed,
      constraints: BoxConstraints.tightFor(
        width: size,
        height: size,
      ),
      shape: const CircleBorder(),
      fillColor: color,
      child: Icon(icon),
    );
  }
}
