import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/appStateController.dart';
import '../../../../../../controllers/lawfirmStateController.dart';
import '../../../../../../routes/app_route_names.dart';

class LitigationHoldBriefView extends StatelessWidget {
  const LitigationHoldBriefView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LawFirmStateController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: (controller.litigationLawyersList.isEmpty)?
                  const Center(
                    child: Text(
                      "No Lawyers Found"
                    ),
                  )
                  :
                  (controller.isLoading)?
            const Center(
              child: SpinKitThreeBounce(
                color: Color(0xff041C40),
              ),
            )
            :
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: (controller.litigationLawyersList.length > 4)? 4 : controller.litigationLawyersList.length,
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
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundImage: (controller.litigationLawyersList[index]["profile_image"] == null)?
                                              const AssetImage("images/profileAvatar.png") as ImageProvider
                                              :
                                              NetworkImage(controller.litigationLawyersList[index]["profile_image"]),
                                            ),
                                            const SizedBox(height: 10,),
                                            Text(
                                              "${controller.litigationLawyersList[index]["first_name"]} ${controller.litigationLawyersList[index]["last_name"]}",
                                              style: const TextStyle(
                                                color: Color(0xff0E0E0E),
                                                fontSize: 16,
                                                fontFamily: "CabinetBold"
                                              ),
                                            ),
                                            const SizedBox(height: 5,),
                                            Text(
                                              "${controller.lawyersList[index]["state"]}, ${controller.lawyersList[index]["country"]}",
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Color(0xff868686),
                                                fontSize: 14
                                              ),
                                            ),
                                            const SizedBox(height: 5,),
                                            Text(
                                              "Year of Call: ${controller.litigationLawyersList[index]["year_of_call"]}",
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
                                                      lfProfileHoldBriefScreen,
                                                    arguments: {
                                                      "userId": controller.litigationLawyersList[index]["_id"],
                                                      "userAuth": controller.litigationLawyersList[index]["_auth"],
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
                                                  "Send Brief",
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
                        (controller.litigationLawyersList.length > 4)?
                        SizedBox(
                          height: 50,
                          width: Get.width,
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(firmSeeAllLawyersScreen);
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