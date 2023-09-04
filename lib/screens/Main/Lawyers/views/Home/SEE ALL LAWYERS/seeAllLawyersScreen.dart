import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/screens/Main/Lawyers/views/Home/SEE%20ALL%20LAWYERS/tabViews/seeAllEmployment.dart';
import 'package:lawploy_app/screens/Main/Lawyers/views/Home/SEE%20ALL%20LAWYERS/tabViews/seeAllHoldBriefs.dart';
import 'package:lawploy_app/screens/Main/Lawyers/views/Home/SEE%20ALL%20LAWYERS/tabViews/seeAllJobFeeds.dart';

import '../../../../../../controllers/lawyerStateController.dart';
import '../../../../../../routes/app_route_names.dart';

class SeeAllLawyersScreen extends StatelessWidget {
  SeeAllLawyersScreen({super.key});

  final LawyerStateController _lawyerStateController = Get.find<LawyerStateController>();

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _lawyerStateController.getAllLawyers();
    });

    return GetBuilder<LawyerStateController>(
      builder: (controller) {
        return DefaultTabController(
          length: 3,
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
                        Tab(
                          text: "Job Offers",
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
                        SeeAllJobFeedView(),
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