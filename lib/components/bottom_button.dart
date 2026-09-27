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
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 20),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            colors: [Color(0xFFFF7A69), kAccentColor],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x66FF5C7A),
              blurRadius: 26,
              offset: Offset(0, 14),
            ),
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(22),
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
