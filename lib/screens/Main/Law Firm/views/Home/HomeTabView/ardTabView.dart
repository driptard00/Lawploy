import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/views/Home/ArdOptionsTabView/employmentView.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/views/Home/ArdOptionsTabView/holdBriefView.dart';


class LFArdView extends StatelessWidget {
  const LFArdView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: const [
              TabBar(
                unselectedLabelColor: Color(0xff868686),
                labelColor: Color(0xff03132B),
                indicatorColor: Color(0xff03132B),
                tabs: [
                  Tab(
                    text: "Hold Brief",
                  ),
                  Tab(
                    text: "Employment",
                  ),
                ]
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ArdHoldBriefView(),
                    ArdEmploymentView(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}