import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import '../../models/calculator_model.dart';

class StandardCalculator extends StatefulWidget {
  const StandardCalculator({super.key});

  @override
  State<StandardCalculator> createState() => _StandardCalculatorState();
}

class _StandardCalculatorState extends State<StandardCalculator> {
  final CalculatorModel _calculator = CalculatorModel();

  Widget _buildButton(
    String text, {
    Color color = const Color(0xFF424242),
    Color textColor = Colors.white,
    double fontSize = 24,
    int flex = 1,
    VoidCallback? onPressed,
  }) {
    Widget buttonText;
    if (text.startsWith('\\') ||
        text.contains('^') ||
        text.contains('/') ||
        text == '√') {
      buttonText = FittedBox(
        fit: BoxFit.scaleDown,
        child: DefaultTextStyle(
          style: TextStyle(color: textColor),
          child: Math.tex(
            text,
            textStyle: TextStyle(
              fontSize: fontSize,
              color: textColor,
            ),
            options: MathOptions(
              style: MathStyle.text,
              fontSize: fontSize,
              color: textColor,
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
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: textColor,
            padding: const EdgeInsets.all(20),
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
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: _calculator.history.isNotEmpty
                    ? FittedBox(
                        fit: BoxFit.scaleDown,
                        child: DefaultTextStyle(
                          style: const TextStyle(color: Colors.grey),
                          child: Math.tex(
                            _calculator.history,
                            textStyle: const TextStyle(
                              fontSize: 24,
                              color: Colors.grey,
                            ),
                            options: MathOptions(
                              style: MathStyle.text,
                              fontSize: 24,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(height: 24),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  _calculator.display,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
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
                      'C',
                      color: Colors.red[700]!,
                      onPressed: () => setState(() => _calculator.clear()),
                    ),
                    _buildButton(
                      '⌫',
                      color: Colors.orange[700]!,
                      onPressed: () => setState(() => _calculator.backspace()),
                    ),
                    _buildButton(
                      '\\frac{1}{x}',
                      color: Colors.blue[700]!,
                      onPressed: () =>
                          setState(() => _calculator.calculateReciprocal()),
                    ),
                    _buildButton(
                      'x^2',
                      color: Colors.blue[700]!,
                      onPressed: () =>
                          setState(() => _calculator.calculateSquare()),
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
                      '+',
                      color: Colors.orange[700]!,
                      onPressed: () =>
                          setState(() => _calculator.setOperator('+')),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    _buildButton(
                      '\\sqrt{x}',
                      color: Colors.blue[700]!,
                      onPressed: () =>
                          setState(() => _calculator.calculateSquareRoot()),
                    ),
                    _buildButton(
                      '=',
                      color: Colors.green[700]!,
                      flex: 3,
                      onPressed: () =>
                          setState(() => _calculator.calculateResult()),
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
