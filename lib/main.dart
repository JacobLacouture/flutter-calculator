import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Jacob's Calculator",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _onPressed(String text) {
    setState(() {
      if (text == 'C') {
        _expression = '';
        _result = '';
      } else if (text == '=') {
        try {
            final expression = Expression.parse(_expression);
            const evaluator = ExpressionEvaluator();
            final result = evaluator.eval(expression, {});
            _result = result.toString();
        } catch (e) {
          _result = 'Error';
        }
      } else if (text == 'x^2') {
        try {
          final expression = Expression.parse(_expression);
          const evaluator = ExpressionEvaluator();
          final result = evaluator.eval(expression, {});
          _expression = '$result*$result';
          final squaredExpression = Expression.parse(_expression);
          final squaredResult = evaluator.eval(squaredExpression, {});
          _result = squaredResult.toString();
        } catch (e) {
          _result = 'Error';
        }
      }else {
        if (_result.isNotEmpty) {
          _expression = '';
          _result = '';
        }
        _expression += text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jacob's Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    _expression,
                    style: const TextStyle(fontSize: 24, color: Colors.black54),
                  ),
                  Text(
                    _result,
                    style: const TextStyle(fontSize: 48, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          _buildButtonRow(['7', '8', '9', '/', 'x^2']),
          _buildButtonRow(['4', '5', '6', '*']),
          _buildButtonRow(['1', '2', '3', '-']),
          _buildButtonRow(['C', '0', '=', '+']),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.map((button) {
          return Expanded(
            child: FilledButton(
              onPressed: () => _onPressed(button), style: FilledButton.styleFrom(
                backgroundColor: Colors.grey[700],
                side: BorderSide(color: Colors.grey[300]!),
              ),
              child: Text(
                button,
                style: const TextStyle(fontSize: 24),
              )
            ),
          );
        }).toList(),
      ),
    );
  }
}