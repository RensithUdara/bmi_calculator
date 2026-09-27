import 'package:flutter/material.dart';
import 'package:bmicalc/constants.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard({
    Key? key,
    required this.colour,
    this.cardChild,
    this.onPress,
    this.isSelected = false,
    this.padding = const EdgeInsets.all(18.0),
    this.margin = const EdgeInsets.all(8.0),
  }) : super(key: key);

  final Color colour;
  final Widget? cardChild;
  final VoidCallback? onPress;
  final bool isSelected;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isSelected ? 1.02 : 1,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      child: GestureDetector(
        onTap: onPress,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: margin,
          padding: padding,
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(22.0),
            border: Border.all(
              color: isSelected ? kAccentColorAlt : kCardBorderColor,
              width: isSelected ? 1.4 : 1,
            ),
            boxShadow: [
              const BoxShadow(
                color: Color(0x66000000),
                blurRadius: 24,
                offset: Offset(0, 18),
              ),
              if (isSelected)
                BoxShadow(
                  color: kAccentColorAlt.withValues(alpha: 0.24),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              const BoxShadow(
                color: Color(0x1AFFFFFF),
                blurRadius: 8,
                offset: Offset(-4, -4),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                isSelected ? const Color(0xFF2E3B61) : colour,
                isSelected ? const Color(0xFF1A2037) : const Color(0xFF111729),
              ],
            ),
          ),
          child: cardChild,
        ),
      ),
    );
  }
}
