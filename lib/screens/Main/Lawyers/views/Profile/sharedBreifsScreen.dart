import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lawploy_app/Widget/PopUps/deletePopups.dart';
import 'package:lawploy_app/controllers/briefStateController.dart';
import 'package:lawploy_app/controllers/lawyerStateController.dart';

import '../../../../../Widget/BottomSheets/myBriefsBottomSheet.dart';
import '../../../../../routes/app_route_names.dart';


class SharedBriefScreen extends StatelessWidget {
  SharedBriefScreen({super.key});

  final BriefStateController _briefStateController = Get.put(BriefStateController());

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _briefStateController.getSharedBriefs();
    });

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
              "Shared Briefs",
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
                color: Color(0xff041C40),
              ),
            )
            :
            (controller.sharedBriefsList.isEmpty)?
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
                const SizedBox(height: 20,),
                const Text(
                  "Delete your shared briefs",
                  style: TextStyle(
                    color: Color(0xff5E5E5E),
                    fontSize: 16,
                  )
                ),
                const SizedBox(height: 20,),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: controller.sharedBriefsList.length,
                        itemBuilder: (context, index) {
                          String timestamp = controller.sharedBriefsList[index]["createdAt"];
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
                          return ListTile(
                            onTap: (){
                              Get.toNamed(
                                lawyerBriefDescriptionScreen,
                                arguments: {
                                  "date": formattedDate,
                                  "time": formattedTime,
                                  "image": controller.myBriefsList[index]["_creator"]["lawyerID"]["profile_image"],
                                  "name": (controller.myBriefsList[index]["_creator"]["lawyerID"] != null)?
                                  controller.myBriefsList[index]["_creator"]["lawyerID"]["first_name"]:
                                  controller.myBriefsList[index]["_creator"]["firmID"]["name"],
                                  "description": controller.myBriefsList[index]["brief"],
                                  "url": controller.myBriefsList[index]["_path"],
                                  "fileName": controller.myBriefsList[index]["name"],
                                }
                              );
                            },
                            leading: Container(
                              height: 37,
                              width: 37,
                              decoration: BoxDecoration(
                                color: const Color(0xffF6EDD1),
                                borderRadius: BorderRadius.circular(37)
                              ),
                              child: const Icon(
                                Icons.receipt_long,
                                color: Color(0xffD3A518),
                              ),
                            ),
                            title: Text(
                              controller.sharedBriefsList[index]["name"],
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
                                  style: TextStyle(
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
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff5E5E5E),
                                  ),
                                ),
                              ],
                            ),
                            trailing: InkWell(
                              onTap: () {
                                DeletePopUps.showDeletePopUps(context, 
                                "images/Trash.png", 
                                "Delete Brief", 
                                "Are you sure you want to delete this brief?", 
                                "No, cancel", 
                                "Yes, delete", 
                                (){Get.back();}, 
                                (){ controller.deleteMyBriefs(controller.sharedBriefsList[index]["_id"]);});
                              },
                              child: const Icon(
                                Iconsax.trash,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          );
                        },
                      )
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