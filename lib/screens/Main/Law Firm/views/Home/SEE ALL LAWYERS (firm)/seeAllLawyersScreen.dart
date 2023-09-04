import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/views/Home/SEE%20ALL%20LAWYERS%20(firm)/tabViews/seeAllEmployment.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/views/Home/SEE%20ALL%20LAWYERS%20(firm)/tabViews/seeAllHoldBriefs.dart';
import '../../../../../../controllers/lawfirmStateController.dart';
import '../../../../../../controllers/lawyerStateController.dart';
import '../../../../../../routes/app_route_names.dart';

class SeeAllLawyersScreenFirm extends StatelessWidget {
  SeeAllLawyersScreenFirm({super.key});

 final LawFirmStateController _lawFirmStateController = Get.find<LawFirmStateController>();

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _lawFirmStateController.getAllLawyers();
    });

    return GetBuilder<LawFirmStateController>(
      builder: (controller) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
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
                "See all",
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
                  Container(
                    height: 47,
                    width: Get.width,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: const Color(0xff767680).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                      ),
                      unselectedLabelColor: Colors.black,
                      labelColor: Colors.black,
                      tabs: const [
                        Tab(
                          text: "Hold Brief",
                        ),
                        Tab(
                          text: "Employment",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SeeAllHoldBriefView(),
                        SeeAllEmploymentView(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}