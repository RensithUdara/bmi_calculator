import 'package:flutter/material.dart';
import 'package:bmicalc/constants.dart';

class IconContent extends StatelessWidget {
  const IconContent({
    Key? key,
    required this.icon,
    required this.label,
    required this.colour,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 58,
          width: 58,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colour.withValues(alpha: 0.16),
            boxShadow: [
              BoxShadow(
                color: colour.withValues(alpha: 0.22),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(icon, size: 31.0, color: colour),
        ),
        const SizedBox(height: 12.0),
        Text(label, style: kLabelTextStyle),
      ],
    );
  }
}
