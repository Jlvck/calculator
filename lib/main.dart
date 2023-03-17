// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import './build_button.dart';

void main() => runApp(Calculator());

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  /// "÷", 1, Colors.blue
  Map buttonKey = {
    "key_1": {
      'key_text': "C" as String,
      'key_height': 1.0 as double,
      'key_color': Colors.redAccent as Color
    },
    'key_2': {
      'key_text': "⌫" as String,
      'key_height': 1.0 as double,
      'key_color': Colors.blue as Color
    },
    'key_3': {
      'key_text': "÷" as String,
      'key_height': 1.0 as double,
      'key_color': Colors.blue as Color
    }
  };
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll("×", '*');
        expression = expression.replaceAll("÷", '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();

          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  List<Widget> buttonList(keyList) {
    final List<Widget> keyList = [];
    buttonKey.forEach((key, value) {
      return keyList.add(setButton(
          value['key_text'] as String,
          value['key_height'] as double,
          value['key_color'] as Color) as Widget);
    });
    return keyList as List<Widget>;
  }

  Widget setButton(String buttonText, double buttonHeight, Color buttonColor) {
    return BuildButton(buttonText, buttonHeight, buttonColor, buttonPressed);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> keyList = [];
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('SimpleCalculator')),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: mediaQuery.size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(children: buttonList(keyList)),
                    TableRow(children: [
                      setButton("7", 1, Colors.black54),
                      setButton("8", 1, Colors.black54),
                      setButton("9", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      setButton("4", 1, Colors.black54),
                      setButton("5", 1, Colors.black54),
                      setButton("6", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      setButton("1", 1, Colors.black54),
                      setButton("2", 1, Colors.black54),
                      setButton("3", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      setButton(".", 1, Colors.black54),
                      setButton("0", 1, Colors.black54),
                      setButton("00", 1, Colors.black54),
                    ]),
                  ],
                ),
              ),
              Container(
                width: mediaQuery.size.width * 0.25,
                child: Table(children: [
                  TableRow(children: [
                    setButton("×", 1, Colors.blue),
                  ]),
                  TableRow(children: [setButton("-", 1, Colors.blue)]),
                  TableRow(children: [setButton("+", 1, Colors.blue)]),
                  TableRow(children: [setButton("=", 2, Colors.redAccent)]),
                ]),
              )
            ],
          )
        ],
      ),
    );
  }
}
