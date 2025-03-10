import 'dart:math';

class CalculatorModel {
  String _display = '0';
  String _firstOperand = '';
  String _operator = '';
  bool _shouldResetDisplay = false;
  String _history = '';

  String get display => _display;
  String get history => _history;

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
    }

    _history = '';
    _display = result.toString();
    if (_display.endsWith('.0')) {
      _display = _display.substring(0, _display.length - 2);
    }
    _firstOperand = '';
    _operator = '';
  }

  void setOperator(String operator) {
    if (_firstOperand.isNotEmpty && !_shouldResetDisplay) {
      _performOperation();
    }
    _operator = operator;
    _firstOperand = _display;
    _history = '$_firstOperand $_operator';
    _shouldResetDisplay = true;
  }

  void calculateResult() {
    if (_firstOperand.isNotEmpty && _operator.isNotEmpty) {
      _history = '$_firstOperand $_operator $_display =';
      _performOperation();
    }
  }

  void calculateSquare() {
    double number = double.parse(_display);
    _history = 'sqr($_display)';
    double result = number * number;
    _display = result.toString();
    if (_display.endsWith('.0')) {
      _display = _display.substring(0, _display.length - 2);
    }
  }

  void calculateSquareRoot() {
    double number = double.parse(_display);
    if (number < 0) {
      _display = '错误';
      _history = '';
      return;
    }
    _history = '√($_display)';
    double result = sqrt(number);
    _display = result.toString();
    if (_display.endsWith('.0')) {
      _display = _display.substring(0, _display.length - 2);
    }
  }

  void calculateReciprocal() {
    double number = double.parse(_display);
    if (number == 0) {
      _display = '错误';
      _history = '';
      return;
    }
    _history = '1/($_display)';
    double result = 1 / number;
    _display = result.toString();
    if (_display.endsWith('.0')) {
      _display = _display.substring(0, _display.length - 2);
    }
  }
}
