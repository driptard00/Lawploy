import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/views/Home/AllOptionsTabViews/employmentView.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/views/Home/AllOptionsTabViews/holdBriefView.dart';


class LFAllViews extends StatelessWidget {
  const LFAllViews({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          child: Column(
            children:  const [
              TabBar(
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
                ]
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    AllHoldBriefView(),
                    AllEmploymentView(),
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