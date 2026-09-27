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
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colour.withValues(alpha: 0.14),
            boxShadow: [
              BoxShadow(
                color: colour.withValues(alpha: 0.18),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(icon, size: 34.0, color: colour),
        ),
        const SizedBox(height: 14.0),
        Text(label, style: kLabelTextStyle),
      ],
    );
  }
}
