import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmicalc/calculator_brain.dart';
import 'package:bmicalc/components/app_background.dart';
import 'package:bmicalc/components/bottom_button.dart';
import 'package:bmicalc/components/icon_content.dart';
import 'package:bmicalc/components/reusable_card.dart';
import 'package:bmicalc/components/round_icon_button.dart';
import 'package:bmicalc/constants.dart';
import 'package:bmicalc/screens/results_page.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender = Gender.male;
  ActivityLevel activityLevel = ActivityLevel.moderate;
  double height = 175;
  double weight = 70;
  int age = 25;

  void _resetValues() {
    setState(() {
      selectedGender = Gender.male;
      activityLevel = ActivityLevel.moderate;
      height = 175;
      weight = 70;
      age = 25;
    });
  }

  void _openResults() {
    final calc = CalculatorBrain(
      height: height,
      weight: weight,
      age: age,
      profile:
          selectedGender == Gender.male ? BodyProfile.male : BodyProfile.female,
      activityLevel: activityLevel,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsPage(report: calc.buildReport()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 820),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _Header(
                          height: height,
                          weight: weight,
                          onReset: _resetValues,
                        ),
                        const SizedBox(height: 12),
                        _GenderSelector(
                          selectedGender: selectedGender,
                          onChanged: (gender) {
                            setState(() => selectedGender = gender);
                          },
                        ),
                        const SizedBox(height: 8),
                        _HeightCard(
                          height: height,
                          onChanged: (value) {
                            setState(() => height = value);
                          },
                        ),
                        const SizedBox(height: 8),
                        _MetricGrid(
                          weight: weight,
                          age: age,
                          onWeightChanged: (value) {
                            setState(() => weight = value.clamp(20, 250));
                          },
                          onAgeChanged: (value) {
                            setState(() => age = value.clamp(1, 120));
                          },
                        ),
                        const SizedBox(height: 8),
                        _ActivitySelector(
                          selected: activityLevel,
                          onChanged: (value) {
                            setState(() => activityLevel = value);
                          },
                        ),
                        BottomButton(
                          buttonTitle: 'CALCULATE',
                          icon: Icons.monitor_heart_outlined,
                          onTap: _openResults,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.height,
    required this.weight,
    required this.onReset,
  });

  final double height;
  final double weight;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final previewBmi = weight / ((height / 100) * (height / 100));

    return ReusableCard(
      colour: const Color(0xD9101A2E),
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(16),
      cardChild: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              'assets/images/healthscale-logo.png',
              height: 58,
              width: 58,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: Text('BMI CALCULATOR', style: kTitleTextStyle),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tune your profile and get a quick wellness snapshot.',
                  style: kBodyTextStyle,
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _MiniPill(
                        text: 'Live BMI ${previewBmi.toStringAsFixed(1)}'),
                    _MiniPill(text: '${height.toStringAsFixed(0)} cm'),
                    _MiniPill(text: '${weight.toStringAsFixed(1)} kg'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Tooltip(
            message: 'Reset values',
            child: RoundIconButton(
              icon: Icons.refresh_rounded,
              onPressed: onReset,
            ),
          ),
        ],
      ),
    );
  }
}

class _GenderSelector extends StatelessWidget {
  const _GenderSelector({
    required this.selectedGender,
    required this.onChanged,
  });

  final Gender selectedGender;
  final ValueChanged<Gender> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ReusableCard(
            onPress: () => onChanged(Gender.male),
            isSelected: selectedGender == Gender.male,
            colour: kInactiveCardColour,
            cardChild: IconContent(
              icon: FontAwesomeIcons.mars,
              colour: selectedGender == Gender.male
                  ? kAccentColorAlt
                  : kInactiveIconColour,
              label: 'MALE',
            ),
          ),
        ),
        Expanded(
          child: ReusableCard(
            onPress: () => onChanged(Gender.female),
            isSelected: selectedGender == Gender.female,
            colour: kInactiveCardColour,
            cardChild: IconContent(
              icon: FontAwesomeIcons.venus,
              colour: selectedGender == Gender.female
                  ? kAccentColor
                  : kInactiveIconColour,
              label: 'FEMALE',
            ),
          ),
        ),
      ],
    );
  }
}

class _HeightCard extends StatelessWidget {
  const _HeightCard({
    required this.height,
    required this.onChanged,
  });

  final double height;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      colour: kActiveCardColour,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      cardChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('HEIGHT', style: kLabelTextStyle),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(height.toStringAsFixed(0), style: kNumberTextStyle),
              const Padding(
                padding: EdgeInsets.only(bottom: 9, left: 6),
                child: Text('cm', style: kLabelTextStyle),
              ),
              const Spacer(),
              _MiniPill(text: '${(height / 30.48).toStringAsFixed(1)} ft'),
            ],
          ),
          const SizedBox(height: 8),
          Slider(
            value: height,
            min: 120,
            max: 220,
            divisions: 100,
            label: '${height.toStringAsFixed(0)} cm',
            onChanged: onChanged,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('120 cm', style: kLabelTextStyle),
              Text('220 cm', style: kLabelTextStyle),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({
    required this.weight,
    required this.age,
    required this.onWeightChanged,
    required this.onAgeChanged,
  });

  final double weight;
  final int age;
  final ValueChanged<double> onWeightChanged;
  final ValueChanged<int> onAgeChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 560;

        final cards = [
          _StepperCard(
            label: 'WEIGHT',
            value: weight.toStringAsFixed(1),
            unit: 'kg',
            onMinus: () => onWeightChanged(weight - 0.5),
            onPlus: () => onWeightChanged(weight + 0.5),
            onMinusLong: () => onWeightChanged(weight - 5),
            onPlusLong: () => onWeightChanged(weight + 5),
          ),
          _StepperCard(
            label: 'AGE',
            value: age.toString(),
            unit: 'yrs',
            onMinus: () => onAgeChanged(age - 1),
            onPlus: () => onAgeChanged(age + 1),
            onMinusLong: () => onAgeChanged(age - 5),
            onPlusLong: () => onAgeChanged(age + 5),
          ),
        ];

        if (isWide) {
          return Row(
              children: cards.map((card) => Expanded(child: card)).toList());
        }

        return Column(children: cards);
      },
    );
  }
}

class _StepperCard extends StatelessWidget {
  const _StepperCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.onMinus,
    required this.onPlus,
    required this.onMinusLong,
    required this.onPlusLong,
  });

  final String label;
  final String value;
  final String unit;
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  final VoidCallback onMinusLong;
  final VoidCallback onPlusLong;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      colour: kActiveCardColour,
      cardChild: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: kLabelTextStyle),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(value, style: kNumberTextStyle),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8, left: 5),
                          child: Text(unit, style: kLabelTextStyle),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  RoundIconButton(
                    icon: FontAwesomeIcons.minus,
                    onPressed: onMinus,
                    onLongPressed: onMinusLong,
                  ),
                  const SizedBox(width: 12),
                  RoundIconButton(
                    icon: FontAwesomeIcons.plus,
                    onPressed: onPlus,
                    onLongPressed: onPlusLong,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActivitySelector extends StatelessWidget {
  const _ActivitySelector({
    required this.selected,
    required this.onChanged,
  });

  final ActivityLevel selected;
  final ValueChanged<ActivityLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      colour: kActiveCardColour,
      padding: const EdgeInsets.all(16),
      cardChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ACTIVITY LEVEL', style: kLabelTextStyle),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: ActivityLevel.values.map((level) {
              final isSelected = selected == level;

              return ChoiceChip(
                selected: isSelected,
                label: Text(level.label),
                avatar: Icon(
                  level == ActivityLevel.low
                      ? Icons.chair_alt_outlined
                      : level == ActivityLevel.moderate
                          ? Icons.directions_run_rounded
                          : Icons.fitness_center_rounded,
                  size: 18,
                ),
                onSelected: (_) => onChanged(level),
                labelStyle: TextStyle(
                  color: isSelected ? kBackgroundBottom : Colors.white,
                  fontWeight: FontWeight.w800,
                ),
                selectedColor: kAccentColorAlt,
                backgroundColor: Colors.white.withValues(alpha: 0.07),
                side: BorderSide(
                  color: isSelected ? kAccentColorAlt : kCardBorderColor,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          Text(selected.description, style: kBodyTextStyle),
        ],
      ),
    );
  }
}

class _MiniPill extends StatelessWidget {
  const _MiniPill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: kCardBorderColor),
      ),
      child: Text(text, style: kLabelTextStyle),
    );
  }
}
