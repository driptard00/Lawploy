import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../CorpOptionsTabView/employmentView.dart';
import '../CorpOptionsTabView/holdBriefView.dart';
import '../CorpOptionsTabView/jobFeedView.dart';

class CorporateView
 extends StatelessWidget {
  const CorporateView
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
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
                    CorpHoldBriefView(),
                    CorpEmploymentView(),
                    CorpJobFeedView()
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