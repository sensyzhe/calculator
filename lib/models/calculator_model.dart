import 'dart:math' as math;

class CalculatorModel {
  String _display = '0';
  String _firstOperand = '';
  String _operator = '';
  bool _shouldResetDisplay = false;
  String _history = '';
  bool _isInRadianMode = false;

  String get display => _display;
  String get history => _history;
  bool get isInRadianMode => _isInRadianMode;

  void clear() {
    _display = '0';
    _firstOperand = '';
    _operator = '';
    _shouldResetDisplay = false;
    _history = '';
  }

  void backspace() {
    if (_display.length > 1) {
      _display = _display.substring(0, _display.length - 1);
    } else {
      _display = '0';
    }
  }

  void toggleSign() {
    if (_display != '0') {
      if (_display.startsWith('-')) {
        _display = _display.substring(1);
      } else {
        _display = '-$_display';
      }
    }
  }

  void addDecimalPoint() {
    if (!_display.contains('.')) {
      _display = '$_display.';
    }
  }

  void addDigit(String digit) {
    if (_shouldResetDisplay) {
      _display = digit;
      _shouldResetDisplay = false;
    } else {
      _display = _display == '0' ? digit : _display + digit;
    }
  }

  void _performOperation() {
    if (_firstOperand.isEmpty || _operator.isEmpty) return;

    double num1 = double.parse(_firstOperand);
    double num2 = double.parse(_display);
    double result = 0;

    switch (_operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '×':
        result = num1 * num2;
        break;
      case '÷':
        if (num2 != 0) {
          result = num1 / num2;
        } else {
          _display = '错误';
          _firstOperand = '';
          _operator = '';
          _history = '';
          return;
        }
        break;
      case '^':
        result = math.pow(num1, num2).toDouble();
        break;
      case 'mod':
        if (num2 != 0) {
          result = num1 % num2;
        } else {
          _display = '错误';
          _firstOperand = '';
          _operator = '';
          _history = '';
          return;
        }
        break;
      case 'log':
        if (num1 > 0 && num2 > 0) {
          result = math.log(num2) / math.log(num1);
        } else {
          _display = '错误';
          _firstOperand = '';
          _operator = '';
          _history = '';
          return;
        }
        break;
    }

    _history = '';
    _display = _formatResult(result);
    _firstOperand = '';
    _operator = '';
  }

  void setOperator(String operator) {
    if (_firstOperand.isNotEmpty && !_shouldResetDisplay) {
      _performOperation();
    }
    _operator = operator;
    _firstOperand = _display;
    switch (operator) {
      case '^':
        _history = '${_formatNumber(_firstOperand)}^{?}';
        break;
      case '×':
        _history = '${_formatNumber(_firstOperand)} \\times';
        break;
      case '÷':
        _history = '${_formatNumber(_firstOperand)} \\div';
        break;
      case 'mod':
        _history = '${_formatNumber(_firstOperand)} \\bmod';
        break;
      case 'log':
        _history = '\\log_{${_formatNumber(_firstOperand)}}(?}';
        break;
      default:
        _history = '${_formatNumber(_firstOperand)} $operator';
    }
    _shouldResetDisplay = true;
  }

  void calculateResult() {
    if (_firstOperand.isNotEmpty && _operator.isNotEmpty) {
      String operator = _operator == '^'
          ? '^{${_display}}'
          : _operator == '×'
              ? '\\times'
              : _operator == '÷'
                  ? '\\div'
                  : _operator == 'mod'
                      ? '\\bmod'
                      : _operator == 'log'
                          ? '\\log_{${_firstOperand}}(${_display})'
                          : _operator;
      _history =
          '${_formatNumber(_firstOperand)} $operator ${_formatNumber(_display)} =';
      _performOperation();
    }
  }

  void calculateSquare() {
    double number = double.parse(_display);
    _history = '${_formatNumber(_display)}^2';
    double result = number * number;
    _display = _formatResult(result);
  }

  void calculateSquareRoot() {
    double number = double.parse(_display);
    if (number < 0) {
      _display = '错误';
      _history = '';
      return;
    }
    _history = '\\sqrt{${_formatNumber(_display)}}';
    double result = math.sqrt(number);
    _display = _formatResult(result);
  }

  void calculateReciprocal() {
    double number = double.parse(_display);
    if (number == 0) {
      _display = '错误';
      _history = '';
      return;
    }
    _history = '\\frac{1}{${_formatNumber(_display)}}';
    double result = 1 / number;
    _display = _formatResult(result);
  }

  void calculateSin() {
    double number = double.parse(_display);
    _history = '\\sin(${_formatNumber(_display)})';
    double result =
        math.sin(_isInRadianMode ? number : _degreesToRadians(number));
    _display = _formatResult(result);
  }

  void calculateCos() {
    double number = double.parse(_display);
    _history = '\\cos(${_formatNumber(_display)})';
    double result =
        math.cos(_isInRadianMode ? number : _degreesToRadians(number));
    _display = _formatResult(result);
  }

  void calculateTan() {
    double number = double.parse(_display);
    _history = '\\tan(${_formatNumber(_display)})';
    double angleInRadians =
        _isInRadianMode ? number : _degreesToRadians(number);
    if ((angleInRadians - math.pi / 2).abs() % math.pi < 1e-10) {
      _display = '错误';
      return;
    }
    double result = math.tan(angleInRadians);
    _display = _formatResult(result);
  }

  void calculateAsin() {
    double number = double.parse(_display);
    if (number < -1 || number > 1) {
      _display = '错误';
      return;
    }
    _history = '\\arcsin(${_formatNumber(_display)})';
    double result = math.asin(number);
    if (!_isInRadianMode) {
      result = _radiansToDegrees(result);
    }
    _display = _formatResult(result);
  }

  void calculateAcos() {
    double number = double.parse(_display);
    if (number < -1 || number > 1) {
      _display = '错误';
      return;
    }
    _history = '\\arccos(${_formatNumber(_display)})';
    double result = math.acos(number);
    if (!_isInRadianMode) {
      result = _radiansToDegrees(result);
    }
    _display = _formatResult(result);
  }

  void calculateAtan() {
    double number = double.parse(_display);
    _history = '\\arctan(${_formatNumber(_display)})';
    double result = math.atan(number);
    if (!_isInRadianMode) {
      result = _radiansToDegrees(result);
    }
    _display = _formatResult(result);
  }

  void calculateLog() {
    double number = double.parse(_display);
    if (number <= 0) {
      _display = '错误';
      return;
    }
    _history = '\\log(${_formatNumber(_display)})';
    double result = math.log(number) / math.ln10;
    _display = _formatResult(result);
  }

  void calculateLn() {
    double number = double.parse(_display);
    if (number <= 0) {
      _display = '错误';
      return;
    }
    _history = '\\ln(${_formatNumber(_display)})';
    double result = math.log(number);
    _display = _formatResult(result);
  }

  void calculateExp() {
    double number = double.parse(_display);
    _history = 'e^{${_formatNumber(_display)}}';
    double result = math.exp(number);
    _display = _formatResult(result);
  }

  void calculateFactorial() {
    int number = int.parse(_display);
    if (number < 0 || number > 170) {
      _display = '错误';
      return;
    }
    _history = '${_formatNumber(_display)}!';
    double result = _factorial(number);
    _display = _formatResult(result);
  }

  void calculatePercent() {
    double number = double.parse(_display);
    _history = '${_formatNumber(_display)}\\%';
    double result = number / 100;
    _display = _formatResult(result);
  }

  void toggleAngleMode() {
    _isInRadianMode = !_isInRadianMode;
  }

  double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  double _radiansToDegrees(double radians) {
    return radians * 180 / math.pi;
  }

  double _factorial(int n) {
    if (n == 0) return 1;
    double result = 1;
    for (int i = 2; i <= n; i++) {
      result *= i;
    }
    return result;
  }

  String _formatResult(double result) {
    if (result.isInfinite || result.isNaN) {
      return '错误';
    }
    String stringResult = result.toString();
    if (stringResult.endsWith('.0')) {
      return stringResult.substring(0, stringResult.length - 2);
    }
    if (result.abs() > 1e16 || (result.abs() < 1e-16 && result != 0)) {
      return result.toStringAsExponential(10);
    }
    return stringResult;
  }

  String _formatNumber(String number) {
    if (number.startsWith('-')) {
      return '(' + number + ')';
    }
    return number;
  }

  void addPi() {
    _display = math.pi.toString();
    _shouldResetDisplay = true;
  }

  void addE() {
    _display = math.e.toString();
    _shouldResetDisplay = true;
  }

  void calculateAbs() {
    double number = double.parse(_display);
    _history = '|${_formatNumber(_display)}|';
    double result = number.abs();
    _display = _formatResult(result);
  }

  void calculateCube() {
    double number = double.parse(_display);
    _history = '${_formatNumber(_display)}^3';
    double result = number * number * number;
    _display = _formatResult(result);
  }

  void calculateCubeRoot() {
    double number = double.parse(_display);
    _history = '\\sqrt[3]{${_formatNumber(_display)}}';
    double result = number < 0
        ? -math.pow(-number, 1 / 3).toDouble()
        : math.pow(number, 1 / 3).toDouble();
    _display = _formatResult(result);
  }
}
