import 'package:flutter_test/flutter_test.dart';
import 'package:hello/calculator_service.dart';
import 'package:hello/injection.dart';

void main() {
  setUpAll(() => configureDependencies());

  group('Calculator Service', () {
    test('adds one to input values', () {
      var calculator = getIt<CalculatorService>();
      expect(calculator.addOne(2), 3);
      expect(calculator.addOne(-7), -6);
      expect(calculator.addOne(0), 1);
    });
  });
}
