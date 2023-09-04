import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/privateStateController.dart';
import 'package:lawploy_app/routes/app_route_names.dart';

class PIProfileScreen extends StatelessWidget {
  const PIProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffF9F9F9),
        elevation: 1,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Color(0xff03132B),
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<PrivateStateController>(
        builder: (controller) {
          return Container(
            height: Get.height,
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: (controller.selectedImage != null)?
                    FileImage(controller.selectedImage!)
                    :
                    (controller.privateIndividual.image != null)?
                    NetworkImage(controller.privateIndividual.image!)
                    :
                    const  AssetImage("images/profileAvatar.png") as ImageProvider
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${controller.privateIndividual.firstName} ${controller.privateIndividual.lastName}",
                    style: const TextStyle(
                      color: Color(0xff0E0E0E),
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    controller.privateIndividual.email!,
                    style: const TextStyle(
                      color: Color(0xff5E5E5E),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Column(
                        children: [
                          _listTile(
                            Container(
                              height: 37,
                              width: 37,
                              decoration: BoxDecoration(
                                color: const Color(0xffF6EDD1),
                                borderRadius: BorderRadius.circular(37)
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Color(0xffD3A518),
                              ),
                            ), 
                            "Profile", 
                            "View and edit your profile",
                            (){
                              Get.toNamed(pieditProfileScreen);
                            }
                          ),
                          _listTile(
                            Container(
                              height: 37,
                              width: 37,
                              decoration: BoxDecoration(
                                color: const Color(0xffF6EDD1),
                                borderRadius: BorderRadius.circular(37)
                              ),
                              child: const Icon(
                                Iconsax.cards5,
                                color: Color(0xffD3A518),
                              ),
                            ), 
                            "Payment", 
                            "View payments arrangements",
                            () {
                              Get.toNamed(paymentScreen);
                            }
                          ),
                          _listTile(
                            Container(
                              height: 37,
                              width: 37,
                              decoration: BoxDecoration(
                                color: const Color(0xffF6EDD1),
                                borderRadius: BorderRadius.circular(37)
                              ),
                              child: const Icon(
                                Icons.settings,
                                color: Color(0xffD3A518),
                              ),
                            ), 
                            "Settings", 
                            "Password, privacy and notification settings",
                            () {
                              Get.toNamed(privateSettingsScreen);
                            }
                          ),
                          _listTile(
                            Container(
                              height: 37,
                              width: 37,
                              decoration: BoxDecoration(
                                color: const Color(0xffF6EDD1),
                                borderRadius: BorderRadius.circular(37)
                              ),
                              child: const Icon(
                                Icons.info_rounded,
                                color: Color(0xffD3A518),
                              ),
                            ), 
                            "Help", 
                            "Get support or feedback",
                            () {
                              Get.toNamed(helpScreen);
                            }
                          ),
                          _listTile(
                            Container(
                              height: 37,
                              width: 37,
                              decoration: BoxDecoration(
                                color: const Color(0xffF6EDD1),
                                borderRadius: BorderRadius.circular(37)
                              ),
                              child: const Icon(
                                Icons.sync,
                                color: Color(0xffD3A518),
                              ),
                            ), 
                            "Switch Profile", 
                            "Get hired by companies and law firms by updating your profile",
                            () {
                               Get.toNamed(allAvailableAccountScreen);
                            }
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      controller.logoutAuth();
                    },
                    child: const Text(
                      "Log out",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xffFF0000),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
  ListTile _listTile(dynamic leadingIcon, String title, String subText, Function() onTap) {
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
        subText,
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