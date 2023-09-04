import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lawploy_app/controllers/interview_state_controller.dart';
import 'package:lawploy_app/routes/app_route_names.dart';

class InterviewView extends StatelessWidget {
  InterviewView({super.key});

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
          SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "View your pending and scheduled interviews here",
                  style: TextStyle(
                    color: Color(0xff5E5E5E),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: controller.allRecievedInterviews.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (context, index) {
                    String timestamp = controller.allRecievedInterviews[index]["createdAt"];
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
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
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
                            controller.allRecievedInterviews[index]["name"],
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff0E0E0E),
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "15th Mar, 2023",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff5E5E5E),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Center(
                                  child: Container(
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffD3A518),
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: const Text(
                                  "10:00 AM",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff5E5E5E),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () {
                              Get.toNamed(
                                  interviewJobDetailScreen,
                                arguments: {
                                    "date": formattedDate,
                                    "time": formattedTime,
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
                                  "name": controller.allRecievedInterviews[index]["name"],
                                  "id": controller.allRecievedInterviews[index]["_id"],
                                  "jobTitle": controller.allRecievedInterviews[index]["job_title"],
                                  "description": controller.allRecievedInterviews[index]["description"],
                                  "responsibilities": controller.allRecievedInterviews[index]["responsibilities"],
                                  "website": controller.allRecievedInterviews[index]["website"],
                                  "state": controller.allRecievedInterviews[index]["state"],
                                }
                              );
                            },
                            child: const Text(
                              "View Details",
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
              ],
            ),
          ),
        );
      }
    );
  }
}