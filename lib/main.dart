import 'package:flutter/material.dart';
import 'package:bmicalc/constants.dart';
import 'package:bmicalc/screens/splash_screen.dart';

void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: const ColorScheme.dark(
          primary: kAccentColor,
          secondary: kAccentColorAlt,
          surface: kSurfaceColor,
        ),
        scaffoldBackgroundColor: kBackgroundBottom,
        sliderTheme: SliderThemeData(
          activeTrackColor: kAccentColorAlt,
          inactiveTrackColor: Colors.white.withValues(alpha: 0.12),
          thumbColor: Colors.white,
          overlayColor: kAccentColorAlt.withValues(alpha: 0.14),
          trackHeight: 8,
        ),
        textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'Roboto',
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      home: const SplashScreen(),
    );
  }
}
