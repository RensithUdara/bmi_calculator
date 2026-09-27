import 'dart:math';

enum ActivityLevel {
  low('Light', 'Desk work, short walks', 1.2),
  moderate('Active', 'Workouts 3-4 days/week', 1.55),
  high('Athlete', 'Hard training most days', 1.725);

  const ActivityLevel(this.label, this.description, this.multiplier);

  final String label;
  final String description;
  final double multiplier;
}

enum BodyProfile {
  male,
  female,
}

class BMIReport {
  const BMIReport({
    required this.bmi,
    required this.category,
    required this.interpretation,
    required this.progress,
    required this.healthyWeightMin,
    required this.healthyWeightMax,
    required this.maintenanceCalories,
    required this.actionSteps,
  });

  final double bmi;
  final String category;
  final String interpretation;
  final double progress;
  final double healthyWeightMin;
  final double healthyWeightMax;
  final int maintenanceCalories;
  final List<String> actionSteps;

  String get bmiText => bmi.toStringAsFixed(1);
  String get healthyWeightRange =>
      '${healthyWeightMin.toStringAsFixed(1)} - ${healthyWeightMax.toStringAsFixed(1)} kg';
}

class CalculatorBrain {
  CalculatorBrain({
    required this.height,
    required this.weight,
    required this.age,
    required this.profile,
    required this.activityLevel,
  }) {
    _calculateBMI();
  }

  final double height;
  final double weight;
  final int age;
  final BodyProfile profile;
  final ActivityLevel activityLevel;
  late double _bmi;

  void _calculateBMI() {
    if (height <= 0 || weight <= 0) {
      throw ArgumentError('Height and weight must be positive values.');
    }
    _bmi = weight / pow(height / 100, 2);
  }

  BMIReport buildReport() {
    final heightMeters = height / 100;
    final healthyMin = 18.5 * pow(heightMeters, 2);
    final healthyMax = 24.9 * pow(heightMeters, 2);
    final bmrOffset = profile == BodyProfile.male ? 5 : -161;
    final bmr = (10 * weight) + (6.25 * height) - (5 * age) + bmrOffset;
    final calories = (bmr * activityLevel.multiplier).round();

    return BMIReport(
      bmi: _bmi,
      category: getResult(),
      interpretation: getInterpretation(),
      progress: (_bmi / 40).clamp(0.0, 1.0),
      healthyWeightMin: healthyMin.toDouble(),
      healthyWeightMax: healthyMax.toDouble(),
      maintenanceCalories: calories,
      actionSteps: _getActionSteps(),
    );
  }

  String getBMI() => _bmi.toStringAsFixed(1);

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
      return 'Your BMI is above the recommended range. A gradual, supported plan can help reduce health risk.';
    } else if (_bmi >= 25) {
      return 'Your BMI is slightly above the recommended range. Small changes in meals and movement can add up.';
    } else if (_bmi >= 18.5) {
      return 'Your BMI is in the recommended range. Keep your nutrition, sleep, and activity balanced.';
    } else {
      return 'Your BMI is below the recommended range. Consider nutrient-dense meals and professional guidance.';
    }
  }

  List<String> _getActionSteps() {
    if (_bmi >= 30) {
      return const [
        'Start with low-impact activity and build consistency.',
        'Prioritize protein, fiber, hydration, and regular sleep.',
        'Talk with a qualified healthcare provider for a tailored plan.',
      ];
    } else if (_bmi >= 25) {
      return const [
        'Add 20-30 minutes of movement most days.',
        'Reduce sugary drinks and highly processed snacks.',
        'Track weight trends weekly instead of daily.',
      ];
    } else if (_bmi >= 18.5) {
      return const [
        'Maintain your current healthy range.',
        'Mix strength training with cardio each week.',
        'Keep an eye on energy, sleep, and stress levels.',
      ];
    } else {
      return const [
        'Increase calories with balanced, nutrient-dense meals.',
        'Add strength training to support lean mass.',
        'Seek advice if weight loss was unplanned.',
      ];
    }
  }
}
