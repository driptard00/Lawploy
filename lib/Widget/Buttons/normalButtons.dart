import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NormalButton {
  static SizedBox normalButton (dynamic onPressed, String text) {
    return SizedBox(
      height: 50,
      width: Get.width,
      child: TextButton(
        onPressed: onPressed, 
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xff041C40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: "CircularStdMedium"
          ),
        ),
      ),
    );
  }
}