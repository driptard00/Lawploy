import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/briefStateController.dart';



class LawyerSendBriefScreen extends StatelessWidget {
  LawyerSendBriefScreen({super.key});

  final BriefStateController _briefStateController = Get.put(BriefStateController());
  final lawyerId = Get.arguments["lawyerId"];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BriefStateController>(
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
              "Send Brief",
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
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Give a brief overview of the brief",
                            style: TextStyle(
                              color: Color(0xff5E5E5E),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 120,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xff041C40)
                                  ),
                                ),
                                child: Center(
                                  child: (controller.selectedFile != null)?
                                    controller.thumbNail
                                  :
                                  const Text(
                                    "Upload your brief here",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            minLines: 6,
                            maxLines: 10,
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
                              hintText: "Write about your brief",
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
                              controller.updateBriefText(value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            width: Get.width,
                            child: TextButton(
                              onPressed: () {
                                controller.createBrief(context, lawyerId);
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
                                "Send Brief",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 50,
                            width: Get.width,
                            child: TextButton(
                              onPressed: () {
                                controller.getBriefFile();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                side: const BorderSide(
                                  color: Color(0xff041C40)
                                )
                              ),
                              child: const Text(
                                "Upload Brief",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff041C40),
                                  fontSize: 16
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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