import 'package:flutter/material.dart';


class PopUps {
  static showPopUps(BuildContext context, String image, String title, String subTitle, String buttonText, dynamic onPressed) {
    showDialog(
      context: context, 
      builder:(context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                image
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xff03132B),
                  fontSize: 20,
                  fontFamily: "CircularStdBold"
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                subTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xff5E5E5E),
                  fontSize: 16
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: TextButton(
                  onPressed: onPressed,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff041C40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  child: Text(
                    buttonText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: "CircularStdMedium"
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}