import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/interview_state_controller.dart';
import 'package:lawploy_app/routes/app_route_names.dart';

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
                    "No feedbacks!"
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
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: (
                                  controller.allRecievedInterviews[index]["_creator"]["corporationID"] != null ?
                                  controller.allRecievedInterviews[index]["_creator"]["corporationID"]["profile_image"] == null
                                  :
                                  controller.allRecievedInterviews[index]["_creator"]["lawyerID"] != null ?
                                  controller.allRecievedInterviews[index]["_creator"]["lawyerID"]["profile_image"] == null
                                  :
                                  controller.allRecievedInterviews[index]["_creator"]["firmID"] != null ?
                                  controller.allRecievedInterviews[index]["_creator"]["firmID"]["profile_image"] == null
                                  :
                                  controller.allRecievedInterviews[index]["_creator"]["privateID"]["profile_image"] == null
                              )?
                              const AssetImage("images/profileAvatar.png") as ImageProvider
                                  :
                              NetworkImage(
                                  (controller.allRecievedInterviews[index]["_creator"]["corporationID"] != null)?
                                  controller.allRecievedInterviews[index]["_creator"]["corporationID"]["profile_image"]
                                  :
                                  (controller.allRecievedInterviews[index]["_creator"]["firmID"] != null)?
                                  controller.allRecievedInterviews[index]["_creator"]["firmID"]["profile_image"]
                                  :
                                    (controller.allRecievedInterviews[index]["_creator"]["lawyerID"] != null)?
                                  controller.allRecievedInterviews[index]["_creator"]["lawyerID"]["profile_image"]
                                  :
                                    (controller.allRecievedInterviews[index]["_creator"]["privateID"] != null)?
                                  controller.allRecievedInterviews[index]["_creator"]["privateID"]["profile_image"]
                                        :
                                        null
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
                                    "image": (
                                        controller.allRecievedInterviews[index]["_creator"]["corporationID"] != null ?
                                        controller.allRecievedInterviews[index]["_creator"]["corporationID"]["profile_image"] == null
                                            :
                                        controller.allRecievedInterviews[index]["_creator"]["lawyerID"] != null ?
                                        controller.allRecievedInterviews[index]["_creator"]["lawyerID"]["profile_image"] == null
                                            :
                                        controller.allRecievedInterviews[index]["_creator"]["firmID"] != null ?
                                        controller.allRecievedInterviews[index]["_creator"]["firmID"]["profile_image"] == null
                                            :
                                        controller.allRecievedInterviews[index]["_creator"]["privateID"]["profile_image"] == null
                                    )?
                                    null
                                    :
                                    (controller.allRecievedInterviews[index]["_creator"]["corporationID"] != null)?
                                    controller.allRecievedInterviews[index]["_creator"]["corporationID"]["profile_image"]
                                        :
                                    (controller.allRecievedInterviews[index]["_creator"]["firmID"] != null)?
                                    controller.allRecievedInterviews[index]["_creator"]["firmID"]["profile_image"]
                                        :
                                    (controller.allRecievedInterviews[index]["_creator"]["lawyerID"] != null)?
                                    controller.allRecievedInterviews[index]["_creator"]["lawyerID"]["profile_image"]
                                        :
                                    (controller.allRecievedInterviews[index]["_creator"]["privateID"] != null)?
                                    controller.allRecievedInterviews[index]["_creator"]["privateID"]["profile_image"]
                                    :
                                   null,
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