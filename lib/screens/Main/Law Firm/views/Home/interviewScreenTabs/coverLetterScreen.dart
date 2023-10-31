import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class CoverLetterScreen extends StatelessWidget {
  CoverLetterScreen({super.key});

  final coverLetter = Get.arguments["cover_letter"];
  // final 

  @override
  Widget build(BuildContext context) {

    print(coverLetter);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Iconsax.arrow_left,
            color: Color(0xff041C40),
          ),
        ),
        backgroundColor: const Color(0xffF9F9F9),
        elevation: 1,
        title: const Text(
          "Cover Letter",
          style: TextStyle(
              color: Color(0xff03132B),
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Cover Letter",
                style: TextStyle(
                  color: Color(0xff0E0E0E),
                  fontSize: 16,
                  fontWeight: FontWeight.w700
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                coverLetter == null ?
                'Nil'
                :
                coverLetter
              ),
            ],
          ),
        ),
      ),
    );
  }
}