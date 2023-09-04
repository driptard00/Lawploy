import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/appStateController.dart';
import 'package:lawploy_app/controllers/lawfirmStateController.dart';

class LawFirmHolderScreen extends StatelessWidget {
  LawFirmHolderScreen({super.key});

  final AppStateController _appStateController = Get.put(AppStateController());
  final LawFirmStateController _lawFirmStateController = Get.put(LawFirmStateController());

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _lawFirmStateController.getLawFirmProfile();
      _lawFirmStateController.getAllLawyers();
    },);
    
    return GetBuilder<AppStateController>(
      builder: (controller) {
        return Scaffold(
          body: controller.lawFirmsScreens[controller.selectedLawFirmScreenIndex],
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
                        controller.updateselectedLawFirmScreenIndex(0);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedLawFirmScreenIndex == 0)?
                            Iconsax.home5
                            :
                            Iconsax.home,
                            color: (controller.selectedLawFirmScreenIndex == 0)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Home",
                            style: TextStyle(
                              color: (controller.selectedLawFirmScreenIndex == 0)?
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
                        controller.updateselectedLawFirmScreenIndex(1);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedLawFirmScreenIndex == 1)?
                            Iconsax.receipt_text5
                            :
                            Iconsax.receipt_text,
                            color: (controller.selectedLawFirmScreenIndex == 1)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Briefs",
                            style: TextStyle(
                              color: (controller.selectedLawFirmScreenIndex == 1)?
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
                        controller.updateselectedLawFirmScreenIndex(2);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedLawFirmScreenIndex == 2)?
                            Iconsax.layer5
                            :
                            Iconsax.layer,
                            color: (controller.selectedLawFirmScreenIndex == 2)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Jobs",
                            style: TextStyle(
                              color: (controller.selectedLawFirmScreenIndex == 2)?
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
                        controller.updateselectedLawFirmScreenIndex(3);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedLawFirmScreenIndex == 3)?
                            Iconsax.message5
                            :
                            Iconsax.message,
                            color: (controller.selectedLawFirmScreenIndex == 3)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Message",
                            style: TextStyle(
                              color: (controller.selectedLawFirmScreenIndex == 3)?
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
                        controller.updateselectedLawFirmScreenIndex(4);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedLawFirmScreenIndex == 4)?
                            Iconsax.profile_circle5
                            :
                            Iconsax.profile_circle,
                            color: (controller.selectedLawFirmScreenIndex == 4)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Profile",
                            style: TextStyle(
                              color: (controller.selectedLawFirmScreenIndex == 4)?
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