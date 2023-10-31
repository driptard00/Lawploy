import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../routes/app_route_names.dart';


class SendFeedbackBottomSheet {
  static showSendFeedbackBottomSheet (String url, fileName, id, auth, name, coverLetter) {
    Get.bottomSheet(
      Container(
        height: 400,
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
            const Row(
              children:  [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Feedback",
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
                Get.toNamed(
                  "",
                );
              },
              title: Text(
                "Send $name a Feedback",
                style: const TextStyle(
                  color: Color(0xff0E0E0E),
                  fontSize: 16,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}