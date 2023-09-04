import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/lawyerStateController.dart';

class JobApplicationScreen extends StatelessWidget {
  JobApplicationScreen({super.key});

  final jobID = Get.arguments["jobID"];
  final LawyerStateController _lawyerStateController = Get.find<LawyerStateController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LawyerStateController>(
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
              "Upload CV",
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Expanded(
                  flex: 9,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        const Text(
                          "Once you upload your resume, it will forward to the company for review",
                          style: TextStyle(
                            color: Color(0xff5E5E5E),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          controller: controller.fileNameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xffCFCFCF),
                                width: 2
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xff041C40),
                                width: 2
                              ),
                            ),
                            hintText: "Upload Resume",
                            hintStyle: const TextStyle(
                              color: Color(0xffAFAFAF),
                              fontSize: 16
                            ),
                            suffixIcon: InkWell(
                              onTap: (){
                                controller.getFile();
                              },
                              child: const Icon(
                                Iconsax.document_upload,
                                size: 20,
                                color: Color(0xffAFAFAF),
                              ),
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: Color(0xff041C40)
                            )
                          ),
                          cursorColor: const Color(0xff041C40),
                          onChanged: (value) {
                            // controller.updateCompanyName(value);
                          },
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          maxLines: 10,
                          minLines: 6,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xffCFCFCF),
                                width: 2
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xff041C40),
                                width: 2
                              ),
                            ),
                            hintText: "Write your Cover Letter",
                            hintStyle: const TextStyle(
                              color: Color(0xffAFAFAF),
                              fontSize: 16
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: Color(0xff041C40)
                            )
                          ),
                          cursorColor: const Color(0xff041C40),
                          onChanged: (value) {
                            controller.updateCoverLetterText(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Center(
                      child: SizedBox(
                        height: 50,
                        width: Get.width,
                        child: TextButton(
                          onPressed: () {
                            (controller.fileUrl == "" || controller.coverLetterText == "")?
                            Fluttertoast.showToast(
                                msg: "Please fill the fields",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 15.0
                            )
                            :
                            controller.applyForAJob(context, jobID);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff041C40),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                          ),
                          child: (controller.isLoading)?
                          const CircularProgressIndicator(
                            color: Colors.white,
                          )
                          :
                          const Text(
                            "Apply",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      ),
                    ),
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