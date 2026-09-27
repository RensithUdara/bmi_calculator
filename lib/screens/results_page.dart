import 'package:flutter/material.dart';
import 'package:bmicalc/calculator_brain.dart';
import 'package:bmicalc/components/bottom_button.dart';
import 'package:bmicalc/components/reusable_card.dart';
import 'package:bmicalc/constants.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({Key? key, required this.report}) : super(key: key);

  final BMIReport report;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kBackgroundTop, kBackgroundBottom],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 820),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ResultsHeader(category: report.category),
                    const SizedBox(height: 18),
                    _ScoreCard(report: report),
                    const SizedBox(height: 10),
                    _InsightGrid(report: report),
                    const SizedBox(height: 10),
                    _ActionCard(steps: report.actionSteps),
                    BottomButton(
                      buttonTitle: 'RE-CALCULATE',
                      icon: Icons.arrow_back_rounded,
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultsHeader extends StatelessWidget {
  const _ResultsHeader({required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundBackButton(onTap: () => Navigator.pop(context)),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Your Result', style: kTitleTextStyle),
              const SizedBox(height: 6),
              Text('BMI category: $category', style: kBodyTextStyle),
            ],
          ),
        ),
      ],
    );
  }
}

class RoundBackButton extends StatelessWidget {
  const RoundBackButton({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(color: kCardBorderColor),
      ),
      child: IconButton(
        tooltip: 'Back',
        onPressed: onTap,
        icon: const Icon(Icons.arrow_back_rounded),
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  const _ScoreCard({required this.report});

  final BMIReport report;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      colour: kActiveCardColour,
      padding: const EdgeInsets.all(24),
      cardChild: Column(
        children: [
          Text(report.category.toUpperCase(), style: kResultTextStyle),
          const SizedBox(height: 6),
          Text(report.bmiText, style: kBMITextStyle),
          const Text('BMI score', style: kLabelTextStyle),
          const SizedBox(height: 22),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: report.progress,
              minHeight: 14,
              backgroundColor: Colors.white.withValues(alpha: 0.10),
              valueColor: const AlwaysStoppedAnimation<Color>(kAccentColorAlt),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            report.interpretation,
            textAlign: TextAlign.center,
            style: kBodyTextStyle,
          ),
        ],
      ),
    );
  }
}

class _InsightGrid extends StatelessWidget {
  const _InsightGrid({required this.report});

  final BMIReport report;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 620;
        final cards = [
          const _InsightCard(
            icon: Icons.verified_outlined,
            label: 'HEALTHY RANGE',
            value: '18.5 - 24.9',
            footnote: 'Recommended BMI window',
          ),
          _InsightCard(
            icon: Icons.monitor_weight_outlined,
            label: 'TARGET WEIGHT',
            value: report.healthyWeightRange,
            footnote: 'For your current height',
          ),
          _InsightCard(
            icon: Icons.local_fire_department_outlined,
            label: 'DAILY ENERGY',
            value: '${report.maintenanceCalories} kcal',
            footnote: 'Estimated maintenance calories',
          ),
        ];

        if (isWide) {
          return Row(
            children: cards.map((card) => Expanded(child: card)).toList(),
          );
        }

        return Column(children: cards);
      },
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.footnote,
  });

  final IconData icon;
  final String label;
  final String value;
  final String footnote;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      colour: kInactiveCardColour,
      padding: const EdgeInsets.all(16),
      cardChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: kAccentColorAlt),
          const SizedBox(height: 12),
          Text(label, style: kLabelTextStyle),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 19,
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 6),
          Text(footnote, style: kCorrectTitleTextStyle),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.steps});

  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      colour: kActiveCardColour,
      padding: const EdgeInsets.all(20),
      cardChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('NEXT BEST STEPS', style: kLabelTextStyle),
          const SizedBox(height: 14),
          ...steps.map(
            (step) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 3),
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: kAccentColorAlt,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      size: 15,
                      color: kBackgroundBottom,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(step, style: kBodyTextStyle)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
