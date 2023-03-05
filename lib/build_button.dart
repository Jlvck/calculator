// ignore_for_file: prefer_const_constructors, duplicate_ignore, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  final String buttonText;
  final double buttonHeight;
  final Color buttonColor;
  Function buttonPressed;

  BuildButton(
      this.buttonText, this.buttonHeight, this.buttonColor, this.buttonPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  // ignore: prefer_const_constructors
                  side: BorderSide(
                      color: Colors.white, width: 1, style: BorderStyle.solid)),
              padding: EdgeInsets.all(16.0)),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            // ignore: prefer_const_constructors
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }
}
