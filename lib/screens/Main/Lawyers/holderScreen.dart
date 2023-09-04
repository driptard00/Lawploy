import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/appStateController.dart';
import 'package:lawploy_app/controllers/lawyerStateController.dart';

class LawyerHolderScreen extends StatelessWidget {
  LawyerHolderScreen({super.key});

  final AppStateController _appStateController = Get.put(AppStateController());
  final LawyerStateController _lawyerStateController = Get.put(LawyerStateController());

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _lawyerStateController.getLawyerDetails();
      _lawyerStateController.getAllLawyers();
      _lawyerStateController.getAllActiveJobs();
    },);
    
    return GetBuilder<AppStateController>(
      builder: (controller) {
        return Scaffold(
          body: controller.lawyerScreens[controller.selectedLawyerScreenIndex],
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 70,
              width: Get.width,
              color: Colors.white,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        controller.updateselectedLawyerScreenIndex(0);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedLawyerScreenIndex == 0)?
                            Iconsax.home5
                            :
                            Iconsax.home,
                            color: (controller.selectedLawyerScreenIndex == 0)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Home",
                            style: TextStyle(
                              color: (controller.selectedLawyerScreenIndex == 0)?
                              const Color(0xff041C40)
                              :
                              const Color(0xffAFAFAF),
                            ),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.updateselectedLawyerScreenIndex(1);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedLawyerScreenIndex == 1)?
                            Iconsax.receipt_text5
                            :
                            Iconsax.receipt_text,
                            color: (controller.selectedLawyerScreenIndex == 1)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Briefs",
                            style: TextStyle(
                              color: (controller.selectedLawyerScreenIndex == 1)?
                              const Color(0xff041C40)
                              :
                              const Color(0xffAFAFAF),
                            ),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.updateselectedLawyerScreenIndex(2);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedLawyerScreenIndex == 2)?
                            Iconsax.layer5
                            :
                            Iconsax.layer,
                            color: (controller.selectedLawyerScreenIndex == 2)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Jobs",
                            style: TextStyle(
                              color: (controller.selectedLawyerScreenIndex == 2)?
                              const Color(0xffD3A518)
                              :
                              const Color(0xffAFAFAF),
                            ),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.updateselectedLawyerScreenIndex(3);
                      },
                      child: Column(
                        children: [
                          Icon(
                           (controller.selectedLawyerScreenIndex == 3)?
                            Iconsax.message5
                            :
                            Iconsax.message,
                            color: (controller.selectedLawyerScreenIndex == 3)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Message",
                            style: TextStyle(
                              color: (controller.selectedLawyerScreenIndex == 3)?
                              const Color(0xff041C40)
                              :
                              const Color(0xffAFAFAF),
                            ),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.updateselectedLawyerScreenIndex(4);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedLawyerScreenIndex == 4)?
                            Iconsax.profile_circle5
                            :
                            Iconsax.profile_circle,
                            color: (controller.selectedLawyerScreenIndex == 4)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Profile",
                            style: TextStyle(
                              color: (controller.selectedLawyerScreenIndex == 4)?
                              const Color(0xff041C40)
                              :
                              const Color(0xffAFAFAF),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}