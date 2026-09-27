import 'package:flutter/material.dart';
import 'package:bmicalc/constants.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    Key? key,
    required this.onTap,
    required this.buttonTitle,
    this.icon,
  }) : super(key: key);

  final VoidCallback onTap;
  final String buttonTitle;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 18),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFFFFC857), Color(0xFFFF5D8F), Color(0xFF78A8FF)],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x55FF5D8F),
              blurRadius: 22,
              offset: Offset(0, 10),
            ),
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: onTap,
            child: SizedBox(
              height: kBottomContainerHeight,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: Colors.white),
                    const SizedBox(width: 10),
                  ],
                  Text(buttonTitle, style: kLargeButtonTextStyle),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
