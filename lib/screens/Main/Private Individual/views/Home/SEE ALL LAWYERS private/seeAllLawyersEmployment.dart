import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/privateStateController.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/views/Home/SEE%20ALL%20LAWYERS%20(firm)/tabViews/seeAllEmployment.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/views/Home/SEE%20ALL%20LAWYERS%20(firm)/tabViews/seeAllHoldBriefs.dart';

import '../../../../../../../controllers/companyStateController.dart';
import '../../../../../../../routes/app_route_names.dart';

class SeeAllLawyersScreenPrivate extends StatelessWidget {
  SeeAllLawyersScreenPrivate({super.key});

 final PrivateStateController _privateStateController = Get.find<PrivateStateController>();

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _privateStateController.getAllLawyers();
    });

    return GetBuilder<PrivateStateController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Iconsax.arrow_left,
                color: Color(0xff041C40),
              ),
            ),
            backgroundColor: const Color(0xffF9F9F9),
            elevation: 1,
            title: const Text(
              "Employment",
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
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 20,),
                Expanded(
                  child: (controller.lawyersList.isEmpty)?
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
        GridView.builder(
          primary: false,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: controller.lawyersList.length,
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
                              backgroundImage: (controller.lawyersList[index]["profile_image"] == null)?
                              const AssetImage("images/profileAvatar.png") as ImageProvider
                              :
                              NetworkImage(controller.lawyersList[index]["profile_image"]),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              "${controller.lawyersList[index]["first_name"]} ${controller.lawyersList[index]["last_name"]}",
                              style: const TextStyle(
                                color: Color(0xff0E0E0E),
                                fontSize: 16,
                                fontFamily: "CabinetBold"
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Text(
                              controller.lawyersList[index]["area"],
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
                              "Year of Call: ${controller.lawyersList[index]["year_of_call"]}",
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
                      "lawyerID": controller.lawyersList[index]["_id"]
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
        )
      
                )
              ],
            ),
          ),
        );
      }
    );
  }
}