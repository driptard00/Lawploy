import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawploy_app/screens/Main/Lawyers/views/Home/AllOptionsTabViews/employmentView.dart';
import 'package:lawploy_app/screens/Main/Lawyers/views/Home/AllOptionsTabViews/holdBriefView.dart';
import 'package:lawploy_app/screens/Main/Lawyers/views/Home/AllOptionsTabViews/jobFeedView.dart';

class AllView extends StatelessWidget {
  const AllView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Container(
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
                    AllHoldBriefView(),
                    AllEmploymentView(),
                    AllJobFeedView()
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