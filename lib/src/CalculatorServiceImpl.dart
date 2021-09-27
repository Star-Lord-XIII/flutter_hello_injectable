import 'package:hello/calculator_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CalculatorService)
class CalculatorServiceImpl implements CalculatorService {
  @override
  int addOne(int value) {
    return value + 1;
  }
}
