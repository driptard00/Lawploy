import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class LFSharedBriefScreen extends StatelessWidget {
  const LFSharedBriefScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: Column(
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
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: (){},
                        leading: Container(
                          height: 37,
                          width: 37,
                          decoration: BoxDecoration(
                            color: const Color(0xffE3E9F1),
                            borderRadius: BorderRadius.circular(37)
                          ),
                          child: const Icon(
                            Icons.receipt_long,
                            color: Color(0xff041C40),
                          ),
                        ),
                        title: const Text(
                          "Brief.png",
                          style: TextStyle(
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
                        trailing: InkWell(
                          onTap: () {
                            
                          },
                          child: const Icon(
                            Iconsax.trash5,
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
}