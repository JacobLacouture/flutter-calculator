import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Jacob's Calculator",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
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
            final evaluator = const ExpressionEvaluator();
            final result = evaluator.eval(expression, {});
            _result = result.toString();
        } catch (e) {
          _result = 'Error';
        }
      } else {
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
          Divider(height: 1),
          _buildButtonRow(['7', '8', '9', '/']),
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
              onPressed: () => _onPressed(button),
              child: Text(
                button,
                style: TextStyle(fontSize: 24),
              ), style: FilledButton.styleFrom(
                backgroundColor: Colors.grey[700],
                side: BorderSide(color: Colors.grey[300]!),
              )
            ),
          );
        }).toList(),
      ),
    );
  }
}