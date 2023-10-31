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

                    String timestamp1 = controller.allRecievedInterviews[index]["invitation"] ?? DateTime.now().toString();
                    var dateTime1 = DateTime.parse(timestamp1).toLocal();
                    var now1= DateTime.now();
                    bool isToday1 = dateTime1.year == now1.year &&
                    dateTime1.month == now1.month &&
                    dateTime1.day == now1.day;

                    // Format date and time
                    String formattedDate1;
                    if (isToday1) {
                      formattedDate1 = 'Today';
                    } else {
                      formattedDate1 = DateFormat('d MMM, y').format(dateTime1);
                    }
                    final formattedTime1 = DateFormat('h:mma').format(dateTime1).toLowerCase();

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
                                controller.allRecievedInterviews[index]['image'] == null
                              )?
                              const AssetImage("images/profileAvatar.png") as ImageProvider
                                  :
                              NetworkImage(
                                controller.allRecievedInterviews[index]['image']
                              ),
                            ),
                          
                          title: Text(
                            controller.allRecievedInterviews[index]["name"],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff0E0E0E),
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  formattedDate,
                                  style: const TextStyle(
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
                                child:  Text(
                                  formattedTime,
                                  style: const TextStyle(
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
                                  "date": formattedDate1,
                                  "time": formattedTime1,
                                    "image": (
                                      controller.allRecievedInterviews[index]['image'] == null
                                    )?
                                    null
                                    :
                                    controller.allRecievedInterviews[index]['image'],
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