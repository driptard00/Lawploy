import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/jobStateController.dart';

import '../../../../../controllers/companyStateController.dart';

class CompanyMyJobScreen extends StatelessWidget {
  CompanyMyJobScreen({super.key});

  final jobID = Get.arguments["jobID"];

  final JobStateController _jobStateController = Get.find<JobStateController>();

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _jobStateController.getSingleJob(jobID);
    },);

    return GetBuilder<JobStateController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xffF9F9F9),
            elevation: 1,
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Iconsax.arrow_left,
                color: Color(0xff041C40),
              ),
            ),
            title: const Text(
              "Job",
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
          Container(
            height: Get.height,
            width: Get.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
                      ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(controller.myJob.image!),
                        ),
                        title: Text(
                          controller.myJob.name!,
                          style: const TextStyle(
                            color: Color(0xff0E0E0E),
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        subtitle: Text(
                          controller.myJob.positionType!,
                          style: const TextStyle(
                            color: Color(0xff5E5E5E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(
                          color: Color(0xffD3D3D3),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "About",
                              style: TextStyle(
                                color: Color(0xff0E0E0E),
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            Text(
                              controller.myJob.description!,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                color: Color(0xff5E5E5E),
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Job Responsibilities",
                              style: TextStyle(
                                color: Color(0xff0E0E0E),
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            Text(
                              controller.myJob.responsibilities!,
                              style: const TextStyle(
                                color: Color(0xff5E5E5E),
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             const Text(
                              "Company’s website",
                              style: TextStyle(
                                color: Color(0xff0E0E0E),
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            Text(
                              controller.myJob.website!,
                              style: const TextStyle(
                                color: Color(0xff4E8BD2),
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             const Text(
                              "Address",
                              style: TextStyle(
                                color: Color(0xff0E0E0E),
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            Text(
                              "${controller.myJob.state!}, ${controller.myJob.country!}",
                              style: const TextStyle(
                                color: Color(0xff5E5E5E),
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             const Text(
                              "Number of applicants",
                              style: TextStyle(
                                color: Color(0xff0E0E0E),
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            Text(
                              controller.applicants.length.toString(),
                              style: const TextStyle(
                                color: Color(0xff5E5E5E),
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}