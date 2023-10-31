import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../controllers/chat_controller.dart';
import '../../controllers/lawyerStateController.dart';
import '../../routes/app_route_names.dart';

class JobFeedProfileScreen extends StatelessWidget {
  JobFeedProfileScreen({super.key});

  final job = Get.arguments["job"];

  final LawyerStateController _lawyerStateController = Get.find<LawyerStateController>();
  final ChatController _chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _lawyerStateController.getOneActiveJobFeed(job["_id"]);
    },);

    return GetBuilder<LawyerStateController>(
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
          body: (controller.isLoading)?
          const Center(
            child: CircularProgressIndicator(
              color: Color(0xff03132B),
            ),
          )
          :
          Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 9,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(controller.jobFeed.image!),
                          ),
                          title: Text(
                            controller.jobFeed.name!,
                            style: const TextStyle(
                              color: Color(0xff0E0E0E),
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          subtitle: Text(
                            controller.jobFeed.positionType!,
                            style: const TextStyle(
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
                            children: [
                              const Text(
                                "About",
                                style: TextStyle(
                                  color: Color(0xff0E0E0E),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              Text(
                                controller.jobFeed.description!,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
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
                                "Job Responsibilities",
                                style: TextStyle(
                                  color: Color(0xff0E0E0E),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              Text(
                                controller.jobFeed.responsibilities!,
                                style: const TextStyle(
                                  color: Color(0xff5E5E5E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        const Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 15),
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
                              Text(
                                "",
                                style: TextStyle(
                                  color: Color(0xff4E8BD2),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: Get.width,
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(
                                jobApplicationScreen,
                                arguments: {
                                  "jobID": job["_id"]
                                }
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xff041C40),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                            ),
                            child: const Text(
                              "Apply",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        ),
                      ],
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