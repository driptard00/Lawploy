import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/routes/app_route_names.dart';

import '../../../../../../controllers/interview_state_controller.dart';

class FeedbackView extends StatelessWidget {
  FeedbackView({super.key});

  final InterviewStateController _interviewStateController = Get.find<InterviewStateController>();

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _interviewStateController.getAllRecievedInterviews();
    });

    return GetBuilder<InterviewStateController>(
      builder: (controller) {
        return Scaffold(
          body: (controller.isLoading)?
          const Center(
            child: SpinKitThreeBounce(
              color: Color(0xff041C40),
            ),
          )
              :
          (controller.allRecievedInterviews.isEmpty)?
          Center(
            child: Column(
              children: [
                Image.asset(
                    "images/noInterview.png"
                ),
                const Text(
                    "No interviews!"
                )
              ],
            ),
          )
              :
          Container(
            child: Column(
              children: [
                const Text(
                  "View your feedbacks and reference letter from companies",
                  style: TextStyle(
                    color: Color(0xff5E5E5E),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.feedbacks.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: ListTile(
                            onTap: (){},
                            leading: Container(
                              height: 37,
                              width: 37,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(37)
                              ),
                            ),
                            title: Text(
                              controller.feedbacks[index]["name"],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xff0E0E0E),
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            trailing: InkWell(
                              onTap: () {
                                Get.toNamed(
                                  interviewFeedbackScreen,
                                  arguments: {
                                    "feedback": controller.feedbacks[index]["feedback"],
                                    "name": controller.feedbacks[index]["name"],
                                    "positionType": controller.feedbacks[index]["position_type"],
                                  }
                                );
                              },
                              child: const Text(
                                "View Feedback",
                                style: TextStyle(
                                  color: Color(0xffD3A518),
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}