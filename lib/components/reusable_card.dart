import 'package:flutter/material.dart';
import 'package:bmicalc/constants.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard({
    Key? key,
    required this.colour,
    this.cardChild,
    this.onPress,
    this.isSelected = false,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(7.0),
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
          width: double.infinity,
          margin: margin,
          padding: padding,
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(28.0),
            border: Border.all(
              color: isSelected ? kAccentColorAlt : kCardBorderColor,
              width: isSelected ? 1.6 : 1,
            ),
            boxShadow: [
              const BoxShadow(
                color: Color(0x40000000),
                blurRadius: 18,
                offset: Offset(0, 12),
              ),
              if (isSelected)
                BoxShadow(
                  color: kAccentColorAlt.withValues(alpha: 0.32),
                  blurRadius: 30,
                  offset: const Offset(0, 8),
                ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                isSelected ? const Color(0xE63D4D7B) : colour,
                isSelected ? const Color(0xD9172040) : const Color(0xBF10182B),
              ],
            ),
          ),
          child: cardChild,
        ),
      ),
    );
  }
}
