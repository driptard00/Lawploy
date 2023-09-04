import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/companyStateController.dart';
import 'package:lawploy_app/controllers/privateStateController.dart';

import '../../../../../../Widget/BottomSheets/jobapplicationBottomSheet.dart';

class JobApplicationView extends StatelessWidget {
   JobApplicationView({super.key});

   final PrivateStateController _companyStateController = Get.put(PrivateStateController());

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _companyStateController.getAllJobData();
    });

    return GetBuilder<PrivateStateController>(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                    "images/noInterview.png"
                ),
                Text(
                    "No job applications!"
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
                    return ListTile(
                      onTap: (){
                        JobApplicationBottomSheet.showJobApplicationBottomSheet(controller.applicants[index]["file"], controller.applicants[index]["_user"]["file"].toString().split("/").last, controller.applicants[index]["_job"], controller.applicants[index]["_user"]["_auth"]);
                      },
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: (controller.applicants[index]["_user"]["profile_image"] == null)?
                        const AssetImage("images/profileAvatar.png") as ImageProvider
                            :
                        NetworkImage(controller.applicants[index]["_user"]["profile_image"]),
                      ),
                      title: Text(
                        "${controller.applicants[index]["_user"]["first_name"]} ${controller.applicants[index]["_user"]["last_name"]}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff0E0E0E),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          const Text(
                            "15th Mar, 2023",
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
                          const Text(
                            "10:00 AM",
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