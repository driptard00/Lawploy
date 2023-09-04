import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/privateStateController.dart';
import '../../../../../Widget/PopUps/deletePopups.dart';
import '../../../../../routes/app_route_names.dart';

class PIJobScreen extends StatelessWidget {
  PIJobScreen({super.key});

  final PrivateStateController _privateStateController = Get.put(PrivateStateController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _privateStateController.getMyJobs();
    },);

    return GetBuilder<PrivateStateController>(
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
            body: (controller.isLoading) ?
            const Center(
              child: CircularProgressIndicator(
                color: Color(0xff03132B),
              ),
            )
                :
            (controller.myJobsList.isEmpty) ?
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: controller.myJobsList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Get.toNamed(
                                    privateMyJobScreen,
                                    arguments: {
                                      "jobID": controller
                                          .myJobsList[index]["_id"]
                                    }
                                );
                              },
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    controller.myJobsList[index]["image"]),
                              ),
                              title: Text(
                                controller.myJobsList[index]["job_title"],
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff0E0E0E),
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              subtitle: Text(
                                controller.myJobsList[index]["position_type"],
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
                                          () {
                                        Get.back();
                                      },
                                          () {
                                        // controller.myJobsList.remove(controller.myJobsList[index]);
                                        controller.deleteMyJob(controller
                                            .myJobsList[index]["_id"]);
                                      }
                                  );
                                },
                                child: (controller
                                    .myJobsList[index]["publish"] == false) ?
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