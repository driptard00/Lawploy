import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lawploy_app/controllers/appStateController.dart';
import 'package:lawploy_app/controllers/companyStateController.dart';
import 'package:lawploy_app/controllers/lawfirmStateController.dart';

import '../../../../../../Widget/BottomSheets/jobapplicationBottomSheet.dart';

class JobApplicationView extends StatelessWidget {
   JobApplicationView({super.key});

   final LawFirmStateController _lawFirmStateController = Get.put(LawFirmStateController());
   final AppStateController _appStateController = Get.find<AppStateController>();

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _appStateController.getAllJobData();
    });

    return GetBuilder<AppStateController>(
      builder: (controller) {
        return Scaffold(
          body: (controller.isLoading)?
          Center(
            child: SpinKitThreeBounce(
              color: Color(0xff041C40),
            ),
          )
              :
          (controller.applicants.isEmpty)?
          Center(
            child: Column(
              children: [
                Image.asset(
                    "images/noInterview.png"
                ),
                Text(
                    "No applications!"
                )
              ],
            ),
          )
              :
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "All job applications will be posted here",
                  style: TextStyle(
                    color: Color(0xff5E5E5E),
                    fontSize: 16,
                  ),
                ),
                ListView.separated(
                  itemCount: controller.applicants.length,
                  primary: false,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Color(0xffCFCFCF),
                    );
                  },
                  itemBuilder: (context, index) {
                      String timestamp = controller.applicants[index]["createdAt"];
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
                        JobApplicationBottomSheet.showJobApplicationBottomSheet(
                          controller.applicants[index]["file"], 
                          controller.applicants[index]["_user"]["file"].toString().split("/").last, 
                          controller.applicants[index]["_job"], 
                          controller.applicants[index]["_user"]["lawyerID"]["_auth"], 
                          controller.applicants[index]["_user"]["lawyerID"]["first_name"], 
                          controller.applicants[index]["_user"]["cover_letter"], 
                        );
                      },
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: (controller.applicants[index]["_user"]["lawyerID"]["profile_image"] == null)?
                        const AssetImage("images/profileAvatar.png") as ImageProvider
                            :
                        NetworkImage(controller.applicants[index]["_user"]["lawyerID"]["profile_image"]),
                      ),
                      title: Text(
                        "${controller.applicants[index]["_user"]["lawyerID"]["first_name"]}",
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
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}