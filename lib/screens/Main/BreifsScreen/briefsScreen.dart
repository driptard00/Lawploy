import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lawploy_app/controllers/briefStateController.dart';

import '../../../../../Widget/BottomSheets/myBriefsBottomSheet.dart';
import '../../../routes/app_route_names.dart';

class MyBriefsScreen extends StatelessWidget {
  MyBriefsScreen({super.key});

  final BriefStateController _briefStateController = Get.put(BriefStateController());

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _briefStateController.getMyBriefs();
    },);

    return GetBuilder<BriefStateController>(
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
                "Briefs",
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
              child: (controller.isLoading)?
              const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff03132B),
                  )
              )
                  :
              (controller.myBriefsList.isEmpty)?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("images/noBriefs.png"),
                  const SizedBox(height: 10,),
                  const Text(
                      "No briefs!"
                  )
                ],
              )
                  :
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "All the briefs shared with you will be displayed here",
                    style: TextStyle(
                      color: Color(0xff5E5E5E),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: controller.myBriefsList.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        String timestamp = controller.myBriefsList[index]["createdAt"];
                        var dateTime = DateTime.parse(timestamp).toLocal();
                        var now = DateTime.now();
                        bool isToday = dateTime.year == now.year &&
                        dateTime.month == now.month &&
                        dateTime.day == now.day;

                        // Format date and time
                        String formattedDate;
                        if (isToday) {
                          formattedDate = 'Today';
                        } else {
                          formattedDate = DateFormat('d MMM, y').format(dateTime);
                        }

                        final formattedTime = DateFormat('h:mma').format(dateTime).toLowerCase();
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: ListTile(
                              onTap: (){
                                Get.toNamed(
                                    lawyerBriefDescriptionScreen,
                                    arguments: {
                                      "date": formattedDate,
                                      "time": formattedTime,
                                      "image": (
                                          controller.myBriefsList[index]["_creator"]["corporationID"] != null ?
                                          controller.myBriefsList[index]["_creator"]["corporationID"]["profile_image"] == null
                                              :
                                          controller.myBriefsList[index]["_creator"]["lawyerID"] != null ?
                                          controller.myBriefsList[index]["_creator"]["lawyerID"]["profile_image"] == null
                                              :
                                          controller.myBriefsList[index]["_creator"]["firmID"] != null ?
                                          controller.myBriefsList[index]["_creator"]["firmID"]["profile_image"] == null
                                              :
                                          controller.myBriefsList[index]["_creator"]["privateID"]["profile_image"] == null
                                      )?
                                      null
                                          :
                                      (controller.myBriefsList[index]["_creator"]["corporationID"] != null)?
                                      controller.myBriefsList[index]["_creator"]["corporationID"]["profile_image"]
                                          :
                                      (controller.myBriefsList[index]["_creator"]["firmID"] != null)?
                                      controller.myBriefsList[index]["_creator"]["firmID"]["profile_image"]
                                          :
                                      (controller.myBriefsList[index]["_creator"]["lawyerID"] != null)?
                                      controller.myBriefsList[index]["_creator"]["lawyerID"]["profile_image"]
                                          :
                                      (controller.myBriefsList[index]["_creator"]["privateID"] != null)?
                                      controller.myBriefsList[index]["_creator"]["privateID"]["profile_image"]
                                          :
                                      null,
                                      "name": (controller.myBriefsList[index]["_creator"]["lawyerID"] != null)?
                                      controller.myBriefsList[index]["_creator"]["lawyerID"]["first_name"]:
                                      controller.myBriefsList[index]["_creator"]["firmID"]["name"],
                                      "description": controller.myBriefsList[index]["brief"],
                                      "url": controller.myBriefsList[index]["_path"],
                                      "fileName": controller.myBriefsList[index]["name"],
                                    }
                                );
                              },
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: (
                                    controller.myBriefsList[index]["_creator"]["corporationID"] != null ?
                                    controller.myBriefsList[index]["_creator"]["corporationID"]["profile_image"] == null
                                        :
                                    controller.myBriefsList[index]["_creator"]["lawyerID"] != null ?
                                    controller.myBriefsList[index]["_creator"]["lawyerID"]["profile_image"] == null
                                        :
                                    controller.myBriefsList[index]["_creator"]["firmID"] != null ?
                                    controller.myBriefsList[index]["_creator"]["firmID"]["profile_image"] == null
                                        :
                                    controller.myBriefsList[index]["_creator"]["privateID"]["profile_image"] == null
                                )?
                                const AssetImage("images/profileAvatar.png") as ImageProvider
                                    :
                                NetworkImage(
                                    (controller.myBriefsList[index]["_creator"]["corporationID"] != null)?
                                    controller.myBriefsList[index]["_creator"]["corporationID"]["profile_image"]
                                        :
                                    (controller.myBriefsList[index]["_creator"]["firmID"] != null)?
                                    controller.myBriefsList[index]["_creator"]["firmID"]["profile_image"]
                                        :
                                    (controller.myBriefsList[index]["_creator"]["lawyerID"] != null)?
                                    controller.myBriefsList[index]["_creator"]["lawyerID"]["profile_image"]
                                        :
                                    (controller.myBriefsList[index]["_creator"]["privateID"] != null)?
                                    controller.myBriefsList[index]["_creator"]["privateID"]["profile_image"]
                                        :
                                    null
                                ),
                              ),
                              title: Text(
                                (controller.myBriefsList[index]["_creator"]["lawyerID"] != null)?
                                "${controller.myBriefsList[index]["_creator"]["lawyerID"]["first_name"]} shared a brief with you"
                                :
                                (controller.myBriefsList[index]["_creator"]["firmID"] != null)?
                                "${controller.myBriefsList[index]["_creator"]["firmID"]["name"]} shared a brief with you"
                                :
                                (controller.myBriefsList[index]["_creator"]["corporationID"] != null)?
                                "${controller.myBriefsList[index]["_creator"]["corporationID"]["name"]} shared a brief with you"
                                :
                                (controller.myBriefsList[index]["_creator"]["privateID"] != null)?
                                "${controller.myBriefsList[index]["_creator"]["privateID"]["name"]} shared a brief with you"
                                :
                                "",
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff0E0E0E),
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    formattedDate,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff5E5E5E),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffD3A518),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    formattedTime,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff5E5E5E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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