import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../controllers/chat_controller.dart';
import '../../../../../controllers/interview_state_controller.dart';
import 'interviewScreenTabs/interviewView.dart';
import 'interviewScreenTabs/jobApplicationView.dart';

class CompanyInterviewScreen extends StatelessWidget {
   CompanyInterviewScreen({super.key});

  final InterviewStateController _interviewStateController = Get.put(InterviewStateController());
  final ChatController _chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffF9F9F9),
          elevation: 1,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Iconsax.arrow_left,
              color: Color(0xff041C40),
            ),
          ),
          title: const Text(
            "Interview",
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 47,
                width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xff767680).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  unselectedLabelColor: const Color(0xff868686),
                  labelColor: const Color(0xff03132B),
                  tabs: const [
                    Tab(
                      text: "Job Application",
                    ),
                    Tab(
                      text: "Interviews",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: TabBarView(
                  children: [
                    JobApplicationView(),
                    InterviewsView(),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}