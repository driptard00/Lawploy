import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/lawfirmStateController.dart';

import '../../../../../Widget/PopUps/deletePopups.dart';
import '../../../../../routes/app_route_names.dart';

class LFJobScreen extends StatelessWidget {
   LFJobScreen({super.key});

  final LawFirmStateController _lawFirmStateController = Get.put(LawFirmStateController());

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _lawFirmStateController.getMyJobs();
    },);

    return GetBuilder<LawFirmStateController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xffF9F9F9),
            elevation: 1,
            title: const Text(
              "Jobs",
              style: TextStyle(
                color: Color(0xff03132B),
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            centerTitle: true,
          ),
          body: (controller.isLoading)?
          const Center(
            child: CircularProgressIndicator(
              color: Color(0xff03132B),
            ),
          )
          :
          (controller.myJobList.isEmpty)?
          Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/noBriefs.png"),
                const Text(
                  "No created jobs!",
                  style: TextStyle(
                    color: Color(0xff363636),
                    fontSize: 16,
                  )
                ),
              ],
            ),
          )
          :
          Container(
            height: Get.height,
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20,),
                const Text(
                  "Manage your created jobs here",
                  style: TextStyle(
                    color: Color(0xff5E5E5E),
                    fontSize: 16,
                  )
                ),
                const SizedBox(height: 10,),
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
                        itemCount: controller.myJobList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: (){
                              Get.toNamed(
                                companyMyJobScreen,
                                arguments: {
                                  "jobID": controller.myJobList[index]["_id"]
                                }
                              );
                            },
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(controller.myJobList[index]["image"]),
                            ),
                            title: Text(
                              controller.myJobList[index]["job_title"],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xff0E0E0E),
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            subtitle: Text(
                              controller.myJobList[index]["position_type"],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xff5E5E5E),
                              ),
                            ),
                            trailing: InkWell(
                              onTap: () {
                                DeletePopUps.showDeletePopUps(
                                  context, 
                                  "images/Trash.png", 
                                  "Delete Job", 
                                  "Are you sure you want to delete this job?", 
                                  "No, cancel", 
                                  "Yes, delete", 
                                  (){
                                  Get.back();
                                  }, 
                                  (){
                                  controller.deleteMyJob(controller.myJobList[index]["_id"]);
                                  }
                                );
                              },
                              child: (controller.myJobList[index]["publish"] == false)?
                              const Text(
                                "Job Closed",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                )
                              )
                              :
                              const Icon(
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