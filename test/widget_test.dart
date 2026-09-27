import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bmicalc/main.dart';

void main() {
  testWidgets('BMI calculator smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const BMICalculator());

    expect(find.text('BMI CALCULATOR'), findsOneWidget);
    expect(find.text('HEIGHT'), findsOneWidget);
    expect(find.text('CALCULATE'), findsOneWidget);
  });
}
