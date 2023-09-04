import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/appStateController.dart';
import 'package:lawploy_app/controllers/privateStateController.dart';

import '../../../controllers/lawyerStateController.dart';

class PIHolderScreen extends StatelessWidget {
  PIHolderScreen({super.key});
  
  final AppStateController _appStateController = Get.put(AppStateController());
  final PrivateStateController _privateStateController = Get.put(PrivateStateController());

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _privateStateController.getPrivateDetails();
      _privateStateController.getAllLawyers();
    },);
    
    return GetBuilder<AppStateController>(
      builder: (controller) {
        return Scaffold(
          body: controller.piScreens[controller.selectedPIScreenIndex],
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
                        controller.updateselectedPIScreenIndex(0);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedPIScreenIndex == 0)?
                            Iconsax.home5
                            :
                            Iconsax.home,
                            color: (controller.selectedPIScreenIndex == 0)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Home",
                            style: TextStyle(
                              color: (controller.selectedPIScreenIndex == 0)?
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
                        controller.updateselectedPIScreenIndex(1);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedPIScreenIndex == 1)?
                            Iconsax.layer5
                            :
                            Iconsax.layer,
                            color: (controller.selectedPIScreenIndex == 1)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Jobs",
                            style: TextStyle(
                              color: (controller.selectedPIScreenIndex == 1)?
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
                        controller.updateselectedPIScreenIndex(2);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedPIScreenIndex == 2)?
                            Iconsax.message5
                            :
                            Iconsax.message,
                            color: (controller.selectedPIScreenIndex == 2)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Message",
                            style: TextStyle(
                              color: (controller.selectedPIScreenIndex == 2)?
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
                        controller.updateselectedPIScreenIndex(3);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedPIScreenIndex == 3)?
                            Iconsax.profile_circle5
                            :
                            Iconsax.profile_circle,
                            color: (controller.selectedPIScreenIndex == 3)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Profile",
                            style: TextStyle(
                              color: (controller.selectedPIScreenIndex == 3)?
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