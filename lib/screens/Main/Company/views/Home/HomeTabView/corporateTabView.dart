import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/appStateController.dart';
import '../../../../../../controllers/companyStateController.dart';
import '../../../../../../routes/app_route_names.dart';


class CompanyCorporateViews extends StatelessWidget {
  const CompanyCorporateViews({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompanyStateController>(
      builder: (controller) {
        return (controller.corporateLawyersList.isEmpty)?
        const Center(
          child: Text(
            "No Lawyers Found"
          ),
        )
        :
        (controller.isLoading)?
        Center(
          child: const CircularProgressIndicator(
            color: Color(0xff0E0E0E),
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
                itemCount: (controller.corporateLawyersList.length > 4)? 4 : controller.corporateLawyersList.length,
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
                                    backgroundImage: (controller.corporateLawyersList[index]["profile_image"] == null)?
                                    const AssetImage("images/profileAvatar.png") as ImageProvider
                                    :
                                    NetworkImage(controller.corporateLawyersList[index]["profile_image"]),
                                  ),
                                  const SizedBox(height: 10,),
                                  Text(
                                    "${controller.corporateLawyersList[index]["first_name"]} ${controller.corporateLawyersList[index]["last_name"]}",
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
                                    "Year of Call: ${controller.corporateLawyersList[index]["year_of_call"]}",
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
                          companyEmploymentScreen,
                          arguments: {
                            "lawyerID": controller.corporateLawyersList[index]["_id"]
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
                                        "Employ",
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
                        (controller.corporateLawyersList.length > 4)?
                        SizedBox(
                          height: 50,
                          width: Get.width,
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(companySeeAllLawyersScreen);
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
        );
      }
    );  
  }
}