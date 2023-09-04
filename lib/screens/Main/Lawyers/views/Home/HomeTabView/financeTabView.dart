import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../FinanceOptionsTabViews/employmentView.dart';
import '../FinanceOptionsTabViews/holdBriefView.dart';
import '../FinanceOptionsTabViews/jobFeedView.dart';

class FinanceView extends StatelessWidget {
  const FinanceView({super.key});

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
                    FinanceHoldBriefView(),
                    FinanceEmploymentView(),
                    FinanceJobFeedView()
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