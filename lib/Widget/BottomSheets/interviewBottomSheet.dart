import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawploy_app/controllers/appStateController.dart';
import 'package:lawploy_app/controllers/chat_controller.dart';
import 'package:lawploy_app/routes/app_route_names.dart';

final ChatController _chatController = Get.find<ChatController>();
final AppStateController _appStateController = Get.put(AppStateController());

class InterviewBottomSheet {
  static showInterviewBottomSheet (String name, id, firstname, lastname, image,) {

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
                    "Interview",
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
                  inputFeedbackScreen,
                  arguments: {
                    "ID": id
                  }
                );
              },
              title: const Text(
                "Send Feedback",
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
                _appStateController.launchGoogleMeet();
              },
              title: const Text(
                "Generate Google Meet link",
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
                _chatController.createConversation(
                  id, 
                  firstname,
                  lastname,
                  image,
                  id,
                );
              },
              title: Text(
                "Message $name",
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