import 'package:flutter_test/flutter_test.dart';

import 'package:bmicalc/main.dart';

void main() {
  testWidgets('BMI calculator smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BMICalculator());

    expect(find.text('BMI CALCULATOR'), findsOneWidget);
    expect(find.text('HEIGHT'), findsOneWidget);
    expect(find.text('CALCULATE'), findsOneWidget);
  });
}
