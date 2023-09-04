import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/briefStateController.dart';

class PIBriefScreen extends StatelessWidget {
  PIBriefScreen({super.key});
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
            automaticallyImplyLeading: false,
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
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: ListTile(
                            onTap: (){},
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: (controller.myBriefsList[index]["_creator"]["lawyerID"]["profile_image"] == null)?
                              const AssetImage("images/profileAvatar.png") as ImageProvider
                              :
                              NetworkImage(controller.myBriefsList[index]["_creator"]["lawyerID"]["profile_image"]),
                            ),
                            title: Text(
                              "${controller.myBriefsList[index]["_creator"]["lawyerID"]["first_name"]} shared a brief with you",
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