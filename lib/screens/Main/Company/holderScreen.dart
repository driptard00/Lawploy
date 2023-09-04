import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/appStateController.dart';
import 'package:lawploy_app/controllers/companyStateController.dart';

import '../../../controllers/lawyerStateController.dart';

class CompanyHolderScreen extends StatelessWidget {
  CompanyHolderScreen({super.key});

  final AppStateController _appStateController = Get.put(AppStateController());
  final CompanyStateController _companyStateController = Get.put(CompanyStateController());

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _companyStateController.getCompanyProfile();
      _companyStateController.getAllLawyers();
    },);
    
    return GetBuilder<AppStateController>(
      builder: (controller) {
        return (controller.isLoading)?
        const Center(
          child: SpinKitThreeBounce(
            color: Color(0xff041C40),
          ),
        )
        :
        Scaffold(
          body: controller.companyScreens[controller.selectedCompanyScreenIndex],
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
                        controller.updateselectedCompanyScreenIndex(0);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedCompanyScreenIndex == 0)?
                            Iconsax.home5
                            :
                            Iconsax.home,
                            color: (controller.selectedCompanyScreenIndex == 0)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Home",
                            style: TextStyle(
                              color: (controller.selectedCompanyScreenIndex == 0)?
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
                        controller.updateselectedCompanyScreenIndex(1);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedCompanyScreenIndex == 1)?
                            Iconsax.layer5
                            :
                            Iconsax.layer,
                            color: (controller.selectedCompanyScreenIndex == 1)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Jobs",
                            style: TextStyle(
                              color: (controller.selectedCompanyScreenIndex == 1)?
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
                        controller.updateselectedCompanyScreenIndex(2);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedCompanyScreenIndex == 2)?
                            Iconsax.message5
                            :
                            Iconsax.message,
                            color: (controller.selectedCompanyScreenIndex == 2)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Message",
                            style: TextStyle(
                              color: (controller.selectedCompanyScreenIndex == 2)?
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
                        controller.updateselectedCompanyScreenIndex(3);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedCompanyScreenIndex == 3)?
                            Iconsax.profile_circle5
                            :
                            Iconsax.profile_circle,
                            color: (controller.selectedCompanyScreenIndex == 3)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Profile",
                            style: TextStyle(
                              color: (controller.selectedCompanyScreenIndex == 3)?
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