import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawploy_app/controllers/lawfirmStateController.dart';

class LawFirmUploadProfilePicture {
  static showLawFirmUploadProfilePicture () {
    Get.bottomSheet(
      GetBuilder<LawFirmStateController>(
        builder: (controller) {
          return Container(
            height: 280,
            width: Get.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white
            ),
            child: Column(
              children: [
                const SizedBox(height: 10,),
                Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xffE7E7E7),
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Profile Picture",
                        style: TextStyle(
                          color: Color(0xff03132B),
                          fontSize: 18,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                ListTile(
                  onTap: () {
                    controller.getImageUrl(ImageSource.camera);
                  },
                  title: const Text(
                    "Take a photo",
                    style: TextStyle(
                      color: Color(0xff0E0E0E),
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: Color(0xffE7E7E7),
                  ),
                ),
                ListTile(
                  onTap: () {
                    controller.getImageUrl(ImageSource.gallery);
                  },
                  title: const Text(
                    "Choose from gallery",
                    style: TextStyle(
                      color: Color(0xff0E0E0E),
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      )
    );
  }
}