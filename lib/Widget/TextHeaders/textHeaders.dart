import 'package:flutter/material.dart';

class TextHeaders {
  static Text textHeaders (String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xff03132B),
        fontSize: 28,
        fontFamily: "CircularStdBold"
      ),
    );
  }
}