import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(KidsMathsGameApp());
}

class KidsMathsGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Math Game',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        useMaterial3: true,
      ),
      home: KidsMathsGame(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class KidsMathsGame extends StatefulWidget {
  @override
  _KidsMathsGameState createState() => _KidsMathsGameState();
}

class _KidsMathsGameState extends State<KidsMathsGame> {
  final Random _random = Random();
  TextEditingController _answerController = TextEditingController();
  int _num1 = 0;
  int _num2 = 0;
  int _result = 0;
  int _userAnswer = 0;
  String _operatorChar = '+';

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    setState(() {
      _num1 = _random.nextInt(10);
      _num2 = _random.nextInt(10);
      int operator = _random.nextInt(4);
      switch (operator) {
        case 0:
          _operatorChar = '+';
          _result = _num1 + _num2;
          break;
        case 1:
          _operatorChar = '-';
          _result = _num1 - _num2;
          break;
        case 2:
          _operatorChar = '*';
          _result = _num1 * _num2;
          break;
        case 3:
          _operatorChar = '/';
          // Make sure the division is valid (no division by zero)
          _num2 = (_num2 == 0) ? 1 : _num2;
          _result = _num1 ~/ _num2;
          break;
        default:
          _operatorChar = '+';
          _result = _num1 + _num2;
      }
    });
  }

  void _checkAnswer() {
    setState(() {
      _userAnswer = int.tryParse(_answerController.text) ?? 0;
      _answerController.clear();
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: (_userAnswer == _result)
              ? Text('Correct! Good job!')
              : Text('Incorrect. The correct answer is $_result.'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                _generateQuestion();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kids Math Game',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'What is $_num1 $_operatorChar $_num2 = ?',
              style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: 100.0,
              child: TextField(
                controller: _answerController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Enter answer',
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _checkAnswer();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }
}
