import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../OAGOptionsTabViews/employmentView.dart';
import '../OAGOptionsTabViews/holdBriefView.dart';
import '../OAGOptionsTabViews/jobFeedView.dart';

class OilAndGasView extends StatelessWidget {
  const OilAndGasView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          child: Column(
            children:  [
              const TabBar(
                unselectedLabelColor: const Color(0xff868686),
                labelColor: Color(0xff03132B),
                indicatorColor: Color(0xff03132B),
                tabs: [
                  Tab(
                    text: "Hold Brief",
                  ),
                  Tab(
                    text: "Employment",
                  ),
                  Tab(
                    text: "Job Feeds",
                  ),
                ]
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    OAGHoldBriefView(),
                    OAGEmploymentView(),
                    OAGJobFeedView()
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