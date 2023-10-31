import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawploy_app/controllers/appStateController.dart';

import '../../../../../../controllers/lawyerStateController.dart';
import '../../../../../../routes/app_route_names.dart';

class ArdJobFeedView extends StatelessWidget {
  ArdJobFeedView({super.key});
  final LawyerStateController _lawyerStateController = Get.find<LawyerStateController>();

  @override
  Widget build(BuildContext context) {

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _lawyerStateController.getAllActiveJobs();
    });

    return GetBuilder<LawyerStateController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: (controller.allActiveJobs.isEmpty)?
                  const Center(
                    child: Text(
                      "No jobs available"
                    ),
                  )
                  :
                  (controller.isLoading)?
                  const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff041C40),
                    )
                  )
                  :
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: (controller.allActiveJobs.length > 4)? 4 : controller.allActiveJobs.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 210
                          ), 
                          itemBuilder:(context, index) {
                            return Container(
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 35,
                                      width: Get.width,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffCFCFCF),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        )
                                      ),
                                    ),
                                    Positioned(
                                      child: Container(
                                        height: Get.height,
                                        width: Get.width,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage(controller.allActiveJobs[index]["image"]),
                                            ),
                                            const SizedBox(height: 10,),
                                            Text(
                                              controller.allActiveJobs[index]["name"],
                                              style: const TextStyle(
                                                color: Color(0xff0E0E0E),
                                                fontSize: 16,
                                                fontFamily: "CabinetBold"
                                              ),
                                            ),
                                            const SizedBox(height: 5,),
                                            Text(
                                              controller.allActiveJobs[index]["job_title"],
                                              style: const TextStyle(
                                                color: Color(0xff868686),
                                                fontSize: 14
                                              ),
                                            ),
                                            const SizedBox(height: 5,),
                                            Text(
                                              "${controller.allActiveJobs[index]["state"]}, ${controller.allActiveJobs[index]["country"]}",
                                              style: const TextStyle(
                                                color: Color(0xff868686),
                                                fontSize: 14
                                              ),
                                            ),
                                            const SizedBox(height: 10,),
                                            SizedBox(
                                              height: 35,
                                              width: 130,
                                              child: TextButton(
                                                onPressed: () {
                                                  Get.toNamed(
                                                    jobFeedProfileScreen,
                                                    arguments: {
                                                      "job": controller.allActiveJobs[index]
                                                    }
                                                  );
                                                },
                                                style: TextButton.styleFrom(
                                                  side: const BorderSide(
                                                    color: Color(0xff041C40)
                                                  ),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                                ),
                                                child: const Text(
                                                  "Apply",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xff041C40),
                                                    fontSize: 14
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20,),
                        (controller.allActiveJobs.length > 4)?
                        SizedBox(
                          height: 50,
                          width: Get.width,
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(seeAllLawyersScreen);
                            },
                            style: TextButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xff041C40)
                              ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                            ),
                            child: const Text(
                              "See all",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff041C40),
                                fontSize: 14
                              ),
                            ),
                          ),
                        )
                        :
                        SizedBox(),
                        const SizedBox(height: 20,),
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