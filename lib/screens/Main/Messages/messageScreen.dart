import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'TabViews/callsScreen.dart';
import 'TabViews/chatsScreen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffF9F9F9),
          elevation: 1,
          title: const Text(
            "Messages",
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 47,
                width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xff767680).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  unselectedLabelColor: const Color(0xff868686),
                  labelColor: const Color(0xff03132B),
                  tabs: const [
                    Tab(
                      text: "Chats",
                    ),
                    Tab(
                      text: "Calls",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: TabBarView(
                  children: [
                    ChatScreenView(),
                    CallsScreenView()
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
  
}