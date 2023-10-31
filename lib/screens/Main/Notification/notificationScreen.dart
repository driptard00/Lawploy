import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lawploy_app/controllers/lawyerStateController.dart';

import '../../../controllers/appStateController.dart';
import '../../../controllers/notification_state_controller.dart';
import '../../../routes/app_route_names.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final AppStateController _appStateController = Get.put(AppStateController());
  final NotificationStateController _notificationStateController = Get.put(NotificationStateController());

  final userType = Get.arguments["type"];

  @override
  Widget build(BuildContext context) {

    final message = Get.arguments;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _appStateController.getAllNotifications();
    },);

    return GetBuilder<AppStateController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xffF9F9F9),
            elevation: 1,
            leading: InkWell(
              onTap: () {
                Get.back();
                // _appStateController.getAllNotifications();
              },
              child: const Icon(
                Iconsax.arrow_left,
                color: Color(0xff041C40),
              ),
            ),
            title: const Text(
              "Notifications",
              style: TextStyle(
                color: Color(0xff03132B),
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  controller.markAllNotification();
                },
                icon: const Icon(
                  Icons.check,
                  color: Color(0xff041C40),
                ),
              )
            ],
          ),
          body:  (controller.isLoading)?
          const Center(
            child: CircularProgressIndicator(
              color: Color(0xff03132B),
            ),
          )
          :
          Container(
            height: Get.height,
            width: Get.width,
            padding: const EdgeInsets.all(20),
            color: const Color(0xffF9F9F9),
            child: (controller.notificationList.isEmpty)?
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "images/noMessages.png",
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "No notifications!",
                  style: TextStyle(
                    color: Color(0xff363636),
                    fontSize: 14,
                  ),
                ),
              ],
            )
            :
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: 
                GroupedListView<dynamic, String>(
                  order: GroupedListOrder.DESC,
                  elements: controller.notificationList,
                  groupBy: (element) {
                    final createdAt = DateTime.parse(element['createdAt']);
                    final now = DateTime.now();
                    final difference = now.difference(createdAt);
                    
                    if (difference.inDays == 0) {
                      return 'Today';
                    } else if (difference.inDays == 1) {
                      return 'Yesterday';
                    } else {
                      // return DateFormat('d MMM y').format(createdAt);
                      return element['createdAt'].toString().split("T").first;
                    }
                  },
                  groupSeparatorBuilder: (String groupByValue) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Text(
                        (groupByValue == "Yesterday" || groupByValue == "Today")?
                        groupByValue
                        :
                        DateFormat('d MMM, y').format(DateTime.parse(groupByValue).toLocal())
                        // groupByValue
                      ),
                    );
                  },
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, dynamic element) {
                  String timestamp = element["createdAt"];
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
                      (element["type"] == "brief")?
                      Get.toNamed(myBriefsScreen)
                      :
                      (element["type"] == "interview")?
                      (userType == "corporation" || userType == "private" || userType == "firm")?
                      Get.toNamed(companyinterviewScreen)
                      :
                      Get.toNamed(jobScreen)
                      :
                      (element["type"] == "jobs")?
                      Get.toNamed(companyinterviewScreen)
                      :
                      Get.back();
                    },
                    
                    leading: Container(
                      height: 37,
                      width: 37,
                      decoration: BoxDecoration(
                        color: const Color(0xffE3E9F1),
                        borderRadius: BorderRadius.circular(37)
                      ),
                      child: Center(
                        child: Badge(
                          isLabelVisible: element["seen"]?
                          false
                          :
                          true,
                          child: const Icon(
                              Iconsax.notification5,
                              color: Color(0xff041C40),
                              size: 24,
                            ),
                        ),
                      ),
                      
                    ),
                    title: Text(
                      element["title"],
                      style: const TextStyle(
                        color: Color(0xff0E0E0E),
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    trailing: Text(
                        formattedTime,
                        style: const TextStyle(
                          color: Color(0xff5E5E5E),
                          fontSize: 12,
                        ),
                      ),
                    subtitle: (element["type"] == "jobs")?
                    const Text(
                      "You have a new Job Application",
                      style: TextStyle(
                        color: Color(0xff5E5E5E),
                        fontSize: 12,
                      ),
                    )
                    :
                    (element["type"] == "brief")?
                    Text(
                      "${
                          (element["from"]["firmID"] != null)?
                          element["from"]["firmID"]["name"]
                          :
                          element["from"]["lawyerID"]["first_name"]
                      } shared a brief with you",
                      style: const TextStyle(
                        color: Color(0xff5E5E5E),
                        fontSize: 12,
                      ),
                    )
                    :
                    (element["type"] == "interview")?
                    Text(
                      "Interview notification from ${
                          (element["from"]["firmID"] != null)?
                          element["from"]["firmID"]["name"]
                          :
                          (element["from"]["corporationID"] != null)?
                          element["from"]["corporationID"]["name"]
                          :
                          (element["from"]["privateID"] != null)?
                          element["from"]["privateID"]["first_name"]
                          :
                          (element["from"]["lawyerID"] != null)?
                          element["from"]["lawyerID"]["first_name"]
                              :
                          null
                      }",
                      style: const TextStyle(
                        color: Color(0xff5E5E5E),
                        fontSize: 12,
                      ),
                    )
                        :
                      null
                  );
                  
                  },
                ),
              
              ),
            ),
          )
        );
      }
    );
  }

}