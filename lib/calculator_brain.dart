import 'dart:math';

class CalculatorBrain {
  CalculatorBrain({required this.height, required this.weight}) {
    _calculateBMI();
  }

  final double height;
  final double weight;
  late double _bmi;

  void _calculateBMI() {
    if (height <= 0 || weight <= 0) {
      throw ArgumentError('Height and weight must be positive values.');
    }
    _bmi = weight / pow(height / 100, 2);
  }

  String getBMI() {
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 30) {
      return 'Obesity';
    } else if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi >= 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String getInterpretation() {
    if (_bmi >= 30) {
      return 'You have a significantly higher than normal body weight. Try to consult a healthcare provider.';
    } else if (_bmi >= 25) {
      return 'You have a higher than normal body weight. Try to exercise more.';
    } else if (_bmi >= 18.5) {
      return 'You have a normal body weight. Good job!';
    } else {
      return 'You have a lower than normal body weight. You can eat a bit more.';
    }
  }
}
