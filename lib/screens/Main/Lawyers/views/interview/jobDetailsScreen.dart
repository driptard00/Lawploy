import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../controllers/interview_state_controller.dart';
import '../../../../../controllers/jobStateController.dart';

class JobDetailScreen extends StatelessWidget {
  JobDetailScreen({super.key});

  final image = Get.arguments["image"];
  final name = Get.arguments["name"];
  final id = Get.arguments["id"];
  final jobTitle = Get.arguments["jobTitle"];
  final description = Get.arguments["description"];
  final responsibilities = Get.arguments["responsibilities"];
  final website = Get.arguments["website"];
  final state = Get.arguments["state"];
  final time = Get.arguments["time"];
  final date = Get.arguments["date"];
  final InterviewStateController _interviewStateController = Get.find<InterviewStateController>();

  @override
  Widget build(BuildContext context) {
    print("STATE:::::$state");
    return GetBuilder<InterviewStateController>(
      builder: (controller) {
        return Scaffold(
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
              "Job",
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                       ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: (image == null)?
                            AssetImage(
                              "images/profileAvatar.png"
                            ) as ImageProvider
                            :
                            NetworkImage(
                              image
                            ),
                          ),
                          title: Text(
                            name,
                            style:  const TextStyle(
                              color: Color(0xff0E0E0E),
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          subtitle: Text(
                            jobTitle,
                            style:  TextStyle(
                              color: Color(0xff5E5E5E),
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Divider(
                            color: Color(0xffD3D3D3),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(
                                "About",
                                style: TextStyle(
                                  color: Color(0xff0E0E0E),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                description,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: Color(0xff5E5E5E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(
                                "Job Responsibilities",
                                style: TextStyle(
                                  color: Color(0xff0E0E0E),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                responsibilities,
                                style: TextStyle(
                                  color: Color(0xff5E5E5E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Date and Time of Interview",
                                style: TextStyle(
                                  color: Color(0xff0E0E0E),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  Text(
                                    date,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff5E5E5E),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffD3A518),
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    time,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff5E5E5E),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(
                                "Company’s website",
                                style: TextStyle(
                                  color: Color(0xff0E0E0E),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                website,
                                style: TextStyle(
                                  color: Color(0xff4E8BD2),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Click accept if you’ll be available for the interview. Once you’ve accepted, you’ll be scheduled for a video call on the interview day.",
                            style: TextStyle(
                              color: Color(0xff0E0E0E),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: (state == "Pending")?
                    Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: Get.width,
                          child: TextButton(
                            onPressed: () {
                              controller.acceptInterviewInvite(context, id, "Accepted");
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xff041C40),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                            ),
                            child: const Text(
                              "Accept",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: Get.width,
                          child: TextButton(
                            onPressed: () {
                              controller.acceptInterviewInvite(context, id, "Rejected");
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                side: const BorderSide(
                                    color: Color(0xffFF0000)
                                )
                            ),
                            child: const Text(
                              "Reject",
                              textAlign: TextAlign.center,
                              style:  TextStyle(
                                  color: Color(0xffFF0000),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                    :
                    (state == "Accepted")?
                    SizedBox(
                      height: 50,
                      width: Get.width,
                      child: TextButton(
                        onPressed: () {
                          // controller.acceptInterviewInvite(context, id, "Rejected");
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            side: const BorderSide(
                                color: Colors.green
                            )
                        ),
                        child: const Text(
                          "Accepted",
                          textAlign: TextAlign.center,
                          style:  TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    )
                    :
                    SizedBox(
                      height: 50,
                      width: Get.width,
                      child: TextButton(
                        onPressed: () {
                          // controller.acceptInterviewInvite(context, id, "Rejected");
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            side: const BorderSide(
                                color: Color(0xffFF0000)
                            )
                        ),
                        child: const Text(
                          "Rejected",
                          textAlign: TextAlign.center,
                          style:  TextStyle(
                              color: Color(0xffFF0000),
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    ),
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