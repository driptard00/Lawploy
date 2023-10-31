import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/routes/app_route_names.dart';

import '../../../../../controllers/privateStateController.dart';

class PrivateSettingScreen extends StatelessWidget {
  const PrivateSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrivateStateController>(
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
              "Settings",
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
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Notifications",
                          style: TextStyle(
                            color: Color(0xff03132B),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                                _listTileSwitch(
                                  Container(
                                    height: 37,
                                    width: 37,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF6EDD1),
                                      borderRadius: BorderRadius.circular(37)
                                    ),
                                    child: const Icon(
                                      Iconsax.directbox_receive5,
                                      color: Color(0xffD3A518),
                                      size: 20,
                                    ),
                                  ), 
                                  "In-app Notification", 
                                  CupertinoSwitch(
                                    value: controller.privateIndividual.inAppNotifcations!,
                                    onChanged: (value) {
                                      controller.updateInAppNotification();
                                    },
                                  )
                                ),
                                _listTileSwitch(
                                  Container(
                                    height: 37,
                                    width: 37,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF6EDD1),
                                      borderRadius: BorderRadius.circular(37)
                                    ),
                                    child: const Icon(
                                      Iconsax.message_notif5,
                                      color: Color(0xffD3A518),
                                      size: 20,
                                    ),
                                  ), 
                                  "Email Notification", 
                                  CupertinoSwitch(
                                    value: controller.privateIndividual.emailNotifcations!,
                                    onChanged: (value) {
                                      controller.updateInEmailNotification();
                                    },
                                  )
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        const Text(
                          "Security",
                          style: TextStyle(
                            color: Color(0xff03132B),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                                      Iconsax.key1,
                                      color: Color(0xffD3A518),
                                      size: 20,
                                    ),
                                  ), 
                                  "Password",
                                  () {
                                    Get.toNamed(privateUpdatePasswordScreen);
                                  }
                                ),
                                _listTileSwitch(
                                  Container(
                                    height: 37,
                                    width: 37,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF6EDD1),
                                      borderRadius: BorderRadius.circular(37)
                                    ),
                                    child: const Icon(
                                      Icons.fingerprint,
                                      color: Color(0xffD3A518),
                                      size: 20,
                                    ),
                                  ), 
                                  "Biometrics", 
                                  CupertinoSwitch(
                                    value: false,
                                    onChanged: (value) {
                                      
                                    },
                                  )
                                ),
                              ],
                            ),
                          ),
                        ),
                        // const SizedBox(height: 20,),
                        // const Text(
                        //   "Privacy",
                        //   style: TextStyle(
                        //     color: Color(0xff03132B),
                        //     fontSize: 16,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Flexible(
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(15)
                        //     ),
                        //     padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        //     child: _listTileSwitch(
                        //       Container(
                        //         height: 37,
                        //         width: 37,
                        //         decoration: BoxDecoration(
                        //           color: const Color(0xffF6EDD1),
                        //           borderRadius: BorderRadius.circular(37)
                        //         ),
                        //         child: const Icon(
                        //           Icons.person,
                        //           color: Color(0xffD3A518),
                        //           size: 20,
                        //         ),
                        //       ), 
                        //       "Keep your profile private", 
                        //       CupertinoSwitch(
                        //         value: controller.privateIndividual.pr,
                        //         onChanged: (value) {
                                  
                        //         },
                        //       )
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: const [
                        //     Expanded(
                        //       flex: 1,
                        //       child: Icon(
                        //         Iconsax.info_circle,
                        //         size: 20,
                        //         color: Color(0xff363636),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       flex: 9,
                        //       child: Text(
                        //         "If turned on, your profile will be hidden from companies and lawyers for possible employment.",
                        //         style: TextStyle(
                        //           color: Color(0xff363636),
                        //           fontSize: 14,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // )
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

  ListTile _listTileArrow(dynamic leadingIcon, String title, Function() onTap) {
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
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Color(0xff041C40),
        size: 20,
      ),
    );
  }

  ListTile _listTileSwitch(dynamic leadingIcon, String title, CupertinoSwitch radio) {
    return ListTile(
      leading: leadingIcon,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xff0E0E0E),
          fontWeight: FontWeight.bold
        ),
      ),
      trailing: radio
    );
  }
}