import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import '../../models/calculator_model.dart';

class ScientificCalculator extends StatefulWidget {
  const ScientificCalculator({super.key});

  @override
  State<ScientificCalculator> createState() => _ScientificCalculatorState();
}

class _ScientificCalculatorState extends State<ScientificCalculator> {
  final CalculatorModel _calculator = CalculatorModel();

  Widget _buildButton(
    String text, {
    Color color = const Color(0xFF424242),
    Color textColor = Colors.white,
    double fontSize = 20,
    int flex = 1,
    VoidCallback? onPressed,
  }) {
    Widget buttonText;
    if (text.startsWith('\\') || text.contains('^') || text.contains('_')) {
      buttonText = FittedBox(
        fit: BoxFit.scaleDown,
        child: DefaultTextStyle(
          style: TextStyle(color: Colors.white),
          child: Math.tex(
            text,
            textStyle: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
            ),
            options: MathOptions(
              style: MathStyle.text,
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      buttonText = FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
          ),
        ),
      );
    }

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: textColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child: Center(child: buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 显示区域
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _calculator.toggleAngleMode();
                        });
                      },
                      child: Text(
                        _calculator.isInRadianMode ? 'RAD' : 'DEG',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    if (_calculator.history.isNotEmpty)
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Math.tex(
                            _calculator.history,
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                            options: MathOptions(
                              style: MathStyle.display,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    _calculator.display,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 0),
        // 按钮区域
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    _buildButton(
                      '\\sin',
                      color: Colors.blue[700]!,
                      onPressed: () =>
                          setState(() => _calculator.calculateSin()),
                    ),
                    _buildButton(
                      '\\cos',
                      color: Colors.blue[700]!,
                      onPressed: () =>
                          setState(() => _calculator.calculateCos()),
                    ),
                    _buildButton(
                      '\\tan',
                      color: Colors.blue[700]!,
                      onPressed: () =>
                          setState(() => _calculator.calculateTan()),
                    ),
                    _buildButton(
                      'C',
                      color: Colors.red[700]!,
                      onPressed: () => setState(() => _calculator.clear()),
                    ),
                    _buildButton(
                      '⌫',
                      color: Colors.orange[700]!,
                      onPressed: () => setState(() => _calculator.backspace()),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    _buildButton(
                      '\\arcsin',
                      color: Colors.blue[700]!,
                      onPressed: () =>
                          setState(() => _calculator.calculateAsin()),
                    ),
                    _buildButton(
                      '\\arccos',
                      color: Colors.blue[700]!,
                      onPressed: () =>
                          setState(() => _calculator.calculateAcos()),
                    ),
                    _buildButton(
                      '\\arctan',
                      color: Colors.blue[700]!,
                      onPressed: () =>
                          setState(() => _calculator.calculateAtan()),
                    ),
                    _buildButton(
                      '(',
                      color: Colors.grey[700]!,
                      onPressed: () {},
                    ),
                    _buildButton(
                      ')',
                      color: Colors.grey[700]!,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    _buildButton(
                      '\\log',
                      color: Colors.blue[700]!,
                      onPressed: () =>
                          setState(() => _calculator.calculateLog()),
                    ),
                    _buildButton(
                      '\\ln',
                      color: Colors.blue[700]!,
                      onPressed: () =>
                          setState(() => _calculator.calculateLn()),
                    ),
                    _buildButton(
                      'e^x',
                      color: Colors.blue[700]!,
                      onPressed: () =>
                          setState(() => _calculator.calculateExp()),
                    ),
                    _buildButton(
                      'x^2',
                      color: Colors.blue[700]!,
                      onPressed: () =>
                          setState(() => _calculator.calculateSquare()),
                    ),
                    _buildButton(
                      '\\sqrt{x}',
                      color: Colors.blue[700]!,
                      onPressed: () =>
                          setState(() => _calculator.calculateSquareRoot()),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    _buildButton(
                      '7',
                      onPressed: () =>
                          setState(() => _calculator.addDigit('7')),
                    ),
                    _buildButton(
                      '8',
                      onPressed: () =>
                          setState(() => _calculator.addDigit('8')),
                    ),
                    _buildButton(
                      '9',
                      onPressed: () =>
                          setState(() => _calculator.addDigit('9')),
                    ),
                    _buildButton(
                      '\\%',
                      color: Colors.blue[700]!,
                      onPressed: () =>
                          setState(() => _calculator.calculatePercent()),
                    ),
                    _buildButton(
                      '÷',
                      color: Colors.orange[700]!,
                      onPressed: () =>
                          setState(() => _calculator.setOperator('÷')),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    _buildButton(
                      '4',
                      onPressed: () =>
                          setState(() => _calculator.addDigit('4')),
                    ),
                    _buildButton(
                      '5',
                      onPressed: () =>
                          setState(() => _calculator.addDigit('5')),
                    ),
                    _buildButton(
                      '6',
                      onPressed: () =>
                          setState(() => _calculator.addDigit('6')),
                    ),
                    _buildButton(
                      'n!',
                      color: Colors.blue[700]!,
                      onPressed: () =>
                          setState(() => _calculator.calculateFactorial()),
                    ),
                    _buildButton(
                      '×',
                      color: Colors.orange[700]!,
                      onPressed: () =>
                          setState(() => _calculator.setOperator('×')),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    _buildButton(
                      '1',
                      onPressed: () =>
                          setState(() => _calculator.addDigit('1')),
                    ),
                    _buildButton(
                      '2',
                      onPressed: () =>
                          setState(() => _calculator.addDigit('2')),
                    ),
                    _buildButton(
                      '3',
                      onPressed: () =>
                          setState(() => _calculator.addDigit('3')),
                    ),
                    _buildButton(
                      'x^y',
                      color: Colors.blue[700]!,
                      onPressed: () =>
                          setState(() => _calculator.setOperator('^')),
                    ),
                    _buildButton(
                      '-',
                      color: Colors.orange[700]!,
                      onPressed: () =>
                          setState(() => _calculator.setOperator('-')),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    _buildButton(
                      '±',
                      onPressed: () => setState(() => _calculator.toggleSign()),
                    ),
                    _buildButton(
                      '0',
                      onPressed: () =>
                          setState(() => _calculator.addDigit('0')),
                    ),
                    _buildButton(
                      '.',
                      onPressed: () =>
                          setState(() => _calculator.addDecimalPoint()),
                    ),
                    _buildButton(
                      '=',
                      color: Colors.green[700]!,
                      onPressed: () =>
                          setState(() => _calculator.calculateResult()),
                    ),
                    _buildButton(
                      '+',
                      color: Colors.orange[700]!,
                      onPressed: () =>
                          setState(() => _calculator.setOperator('+')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
