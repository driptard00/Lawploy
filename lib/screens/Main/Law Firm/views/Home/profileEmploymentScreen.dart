import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lawploy_app/controllers/companyStateController.dart';

import '../../../../../controllers/lawfirmStateController.dart';
import '../../../../../controllers/lawyerStateController.dart';
import '../../../../../routes/app_route_names.dart';

class LawFirmProfileEmploymentScreen extends StatelessWidget {
  LawFirmProfileEmploymentScreen({super.key});

  final LawFirmStateController _lawFirmStateController = Get.find<LawFirmStateController>();
  var format = NumberFormat("#,##0");

  final id = Get.arguments["lawyerID"];

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _lawFirmStateController.getSingleLawyer(id);
    },);
    
    return GetBuilder<LawFirmStateController>(
      builder: (controller) {
        return Scaffold(
          body: (controller.isLoading)?
                const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff03132B),
                  ),
                )
                :
          Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                Expanded(
                  flex: 9,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              "images/rectangleTop.png",
                              fit: BoxFit.cover,
                              width: Get.width,
                            ),
                            SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: const Icon(
                                        Iconsax.arrow_left,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 40,
                              child: Container(
                                width: Get.width,
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: (controller.otherLawyer.profileImage == null)?
                                      const AssetImage("images/profileAvatar.png") as ImageProvider
                                      :
                                      NetworkImage(controller.otherLawyer.profileImage),
                                    ),
                                    const SizedBox(height: 20,),
                                    Text(
                                      "${controller.otherLawyer.firstName!} ${controller.otherLawyer.lastName!}",
                                      style: const TextStyle(
                                        color: Color(0xff0E0E0E),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    const SizedBox(height: 5,),
                                    Text(
                                      controller.otherLawyer.email!,
                                      style: const TextStyle(
                                        color: Color(0xff868686),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          controller.otherLawyer.area!,
                                          style: const TextStyle(
                                              color: Color(0xff0E0E0E),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            const Text(
                                              "From",
                                              style: TextStyle(
                                                  color: Color(0xff868686),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400
                                              ),
                                            ),
                                            const SizedBox(width: 5,),
                                            Text(
                                              "N${format.format(controller.otherLawyer.briefMinAmount!)}",
                                              style: const TextStyle(
                                                  color: Color(0xff0E0E0E),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Year Of Call - ${controller.otherLawyer.yearOfCall!}",
                                        style: const TextStyle(
                                            color: Color(0xff868686),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 14,
                                          ),
                                          Text(
                                            "4.5(10)",
                                            style: TextStyle(
                                                color: Color(0xff868686),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "About",
                                    style: TextStyle(
                                        color: Color(0xff0E0E0E),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),
                                  Text(
                                    controller.otherLawyer.bio!,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                        color: Color(0xff5E5E5E),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Practice Area",
                                          style:  TextStyle(
                                              color: Color(0xff0E0E0E),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                          controller.otherLawyer.area!,
                                          style: const TextStyle(
                                            color: Color(0xff5E5E5E),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          height: 41,
                                          width: 84,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(25),
                                              boxShadow: const [
                                                BoxShadow(
                                                    blurRadius: 5,
                                                    offset: Offset(1, 1),
                                                    color: Color.fromARGB(1, 0, 0, 0)
                                                ),
                                              ]
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Iconsax.messages5,
                                                size: 20,
                                                color: Color(0xffD3A518),
                                              ),
                                              SizedBox(width: 5,),
                                              Text(
                                                "Chat",
                                                style: TextStyle(
                                                    color: Color(0xff0E0E0E),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 24,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Contact",
                                    style: TextStyle(
                                        color: Color(0xff0E0E0E),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Container(
                                        height: 37,
                                        width: 37,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffF6EDD1),
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        child: const Icon(
                                          Iconsax.call_calling5,
                                          size: 20,
                                          color: Color(0xffD3A518),
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:  [
                                          Text(
                                            "Phone number",
                                            style: TextStyle(
                                                color: Color(0xff0E0E0E),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700
                                            ),
                                          ),
                                          Text(
                                            controller.otherLawyer.phoneNumber!,
                                            style: const TextStyle(
                                                color: Color(0xff5E5E5E),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: Get.width,
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(
                                  inviteForInterviewScreen,
                                  arguments: {
                                    "recieverAuth": controller.otherLawyer.auth
                                  }
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xff041C40),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                            ),
                            child: const Text(
                              "Invite for Interview",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}