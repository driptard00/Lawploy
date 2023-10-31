import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lawploy_app/Widget/BottomSheets/interviewBottomSheet.dart';
import 'package:lawploy_app/controllers/chat_controller.dart';
import 'package:lawploy_app/controllers/interview_state_controller.dart';
import 'package:lawploy_app/routes/app_route_names.dart';

import '../../../../../../controllers/appStateController.dart';

class InterviewsView extends StatelessWidget {
  InterviewsView({super.key});

  final InterviewStateController _interviewStateController = Get.find<InterviewStateController>();
  final ChatController _chatController = Get.find<ChatController>();
  final AppStateController _appStateController = Get.find<AppStateController>();


  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _appStateController.getAllSentInterviews();
    });

    return GetBuilder<AppStateController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            child: (controller.isLoading)?
            const Center(
              child: SpinKitThreeBounce(
                color: Color(0xff041C40),
              ),
            )
            :
            (controller.sentList.isEmpty)?
            Center(
              child: Column(
                children: [
                  Image.asset(
                    "images/noInterview.png"
                  ),
                  const Text(
                    "You've not sentList any interviews"
                  )
                ],
              ),
            )
            :
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "All interview invitation will be posted view. Once an applicant accept the interview invitation, you can generate a meeting link for the interview on the interview date.",
                    style: TextStyle(
                      color: Color(0xff5E5E5E),
                      fontSize: 16,
                    ),
                  ),
                  ListView.separated(
                    itemCount: controller.sentList.length,
                    primary: false,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Color(0xffCFCFCF),
                      );
                    },
                    itemBuilder: (context, index) {
                      String timestamp = controller.sentList[index]["createdAt"];
                      var dateTime = DateTime.parse(timestamp).toLocal();
                      var now = DateTime.now();
                      bool isToday = dateTime.year == now.year &&
                      dateTime.month == now.month &&
                      dateTime.day == now.day;

                      // Format date and time
                      String formattedDate;
                      if (isToday) {
                        formattedDate = 'Today';
                      } else {
                        formattedDate = DateFormat('d MMM, y').format(dateTime);
                      }

                      final formattedTime = DateFormat('h:mma').format(dateTime).toLowerCase();
                      return ListTile(
                        onTap: (){
                          (controller.sentList[index]["state"] == "Accepted")?
                          InterviewBottomSheet.showInterviewBottomSheet(
                            controller.sentList[index]["_recevier"]["lawyerID"]["first_name"], 
                            controller.sentList[index]["_recevier"]["_id"], 
                            controller.sentList[index]["_recevier"]["lawyerID"]["first_name"],
                            "", 
                            controller.sentList[index]["_recevier"]["lawyerID"]["profile_image"]
                          )
                          :
                          (controller.sentList[index]["state"] == "Rejected")?
                          Get.toNamed(
                            inputFeedbackScreen,
                            arguments: {
                              "ID": controller.sentList[index]["_id"]
                            }
                          )
                          :
                          Get.toNamed(
                            inputFeedbackScreen,
                            arguments: {
                              "ID": controller.sentList[index]["_id"]
                            }
                          );
                        },
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: (controller.sentList[index]["_recevier"]["lawyerID"]["profile_image"] == null)?
                          const AssetImage("images/profileAvatar.png") as ImageProvider
                              :
                          NetworkImage(controller.sentList[index]["_recevier"]["lawyerID"]["profile_image"]),
                        ),
                        title: Text(
                          controller.sentList[index]["_recevier"]["lawyerID"]["first_name"],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff0E0E0E),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        subtitle: Text(
                          formattedDate,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff5E5E5E),
                          ),
                        ),
                        trailing: (controller.sentList[index]["state"] == "Pending")?
                        Container(
                          height: 31,
                          width: 130,
                          decoration: BoxDecoration(
                            color: const Color(0xff041C40),
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child:const Center(
                            child:  Text(
                              "Awaiting Acceptance",
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          ),
                        )
                        :
                        (controller.sentList[index]["state"] == "Accepted")?
                        const Text(
                          "Continue",
                          style: TextStyle(
                            color: Colors.green,
                            decoration: TextDecoration.underline
                          ),
                        )
                        :
                        const Text(
                          "Rejected",
                          style: TextStyle(
                            color: Color(0xffFF0000),
                            decoration: TextDecoration.underline
                          ),
                        )

                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}