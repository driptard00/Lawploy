import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/jobStateController.dart';

class PositionTypes {
  static showPositionTypes () {
    Get.bottomSheet(
      GetBuilder<JobStateController>(
        builder: (controller) {
          return Container(
            height: 400,
            width: Get.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white
            ),
            child: Column(
              children: [
                const SizedBox(height: 10,),
                Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xffE7E7E7),
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Position Type",
                        style: TextStyle(
                          color: Color(0xff03132B),
                          fontSize: 18,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: ListView.separated(
                    // primary: false,
                    // shrinkWrap: true,
                    itemCount: controller.positionTypes.length,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: controller.positionTypes[index], 
                        groupValue: controller.positiontype, 
                        onChanged:(value) {
                          controller.updatePositionType(value);
                        },
                        title: Text(
                          controller.positionTypes[index]
                        ),
                        activeColor: const Color(0xffD3A518),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          color: const Color(0xffE7E7E7).withOpacity(0.5),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        }
      ),
      isScrollControlled: true
    );
  }
}