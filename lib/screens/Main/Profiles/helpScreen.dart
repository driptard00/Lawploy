import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/appStateController.dart';

import '../../../routes/app_route_names.dart';

class HelpScreen extends StatelessWidget {
  HelpScreen({super.key});

  final AppStateController _appStateController = Get.put(AppStateController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppStateController>(
      builder: (controller) {
        return Scaffold(
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
              "Help",
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      child: Column(
                        children: [
                          _listTileArrow(
                             Container(
                              height: 37,
                              width: 37,
                              decoration: BoxDecoration(
                                color: const Color(0xffF6EDD1),
                                borderRadius: BorderRadius.circular(37)
                              ),
                              child: const Icon(
                                Iconsax.messages_25,
                                color: Color(0xffD3A518),
                                size: 20,
                              ),
                            ),
                            "Chat with us", 
                            "Start a conversation with us",
                            () async{
                              controller.launchWhatsApp();
                            }
                          ),
                          _listTileArrow(
                             Container(
                              height: 37,
                              width: 37,
                              decoration: BoxDecoration(
                                color: const Color(0xffF6EDD1),
                                borderRadius: BorderRadius.circular(37)
                              ),
                              child: const Icon(
                                Iconsax.message_question5,
                                color: Color(0xffD3A518),
                                size: 20,
                              ),
                            ),
                            "FAQs", 
                            "Find intelligent answers instantly",
                            () {
                              Get.toNamed(faqsScreen);
                            }
                          ),
                          _listTileArrow(
                             Container(
                              height: 37,
                              width: 37,
                              decoration: BoxDecoration(
                                color: const Color(0xffF6EDD1),
                                borderRadius: BorderRadius.circular(37)
                              ),
                              child: const Icon(
                                Iconsax.message_text5,
                                color: Color(0xffD3A518),
                                size: 20,
                              ),
                            ),
                            "Email", 
                            "Get a solution beamed to your inbox",
                            () {
                              controller.launchEmail();
                            }
                          ),
                        ],
                      ),
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

  ListTile _listTileArrow(dynamic leadingIcon, String title, String subtitle,Function() onTap) {
    return ListTile(
      onTap: onTap,
      leading: leadingIcon,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xff0E0E0E),
          fontWeight: FontWeight.bold
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xff5E5E5E),
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Color(0xff041C40),
        size: 20,
      ),
    );
  }

  }