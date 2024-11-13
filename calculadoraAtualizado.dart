import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, 
          brightness: Brightness.dark, 
        ),
        useMaterial3: true,
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
  String _display = ''; 
  double _firstNumber = 0; 
  String _operator = ''; 

  // Função para atualizar o display
  void _updateDisplay(String value) {
    setState(() {
      _display += value; 
    });
  }

  // Função para executar a operação
  void _calculate(String operation) {
    setState(() {
      if (operation == '=') {
        double secondNumber = double.parse(_display.split(_operator)[1]);
        if (_operator == '+') {
          _display = (_firstNumber + secondNumber).toString();
        } else if (_operator == '-') {
          _display = (_firstNumber - secondNumber).toString();
        } else if (_operator == '*') {
          _display = (_firstNumber * secondNumber).toString();
        } else if (_operator == '/') {
          _display = (_firstNumber / secondNumber).toString();
        }
      } else {
        _firstNumber = double.parse(_display); 
        _operator = operation; 
        _display += operation;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculadora',
          style: TextStyle(color: Colors.white), 
        ),
        backgroundColor: Colors.black, 
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                _display,
                style: const TextStyle(
                  fontSize: 30, 
                  fontWeight: FontWeight.bold, 
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                for (var row in [
                  ['7', '8', '9', '/'],
                  ['4', '5', '6', '*'],
                  ['1', '2', '3', '-'],
                  ['0', '.', '=', '+']
                ])
                  Expanded(
                    child: Row(
                      children: [
                        for (var item in row)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (item == '=') {
                                    _calculate(item);
                                  } else if (['+', '-', '*', '/'].contains(item)) {
                                    _calculate(item); 
                                  } else {
                                    _updateDisplay(item);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor: ['+', '-', '*', '/'].contains(item)
                                      ? const Color.fromARGB(255, 0, 255, 21)
                                      : Colors.blue, 
                                ),
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 24, 
                                    color: Colors.white, 
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
