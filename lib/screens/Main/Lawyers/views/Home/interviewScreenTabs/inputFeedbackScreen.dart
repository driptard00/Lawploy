import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/interview_state_controller.dart';
import 'package:lawploy_app/controllers/lawyerStateController.dart';

class InputFeedbackScreen extends StatelessWidget {
  InputFeedbackScreen({super.key});

  final ID = Get.arguments["ID"];
  final InterviewStateController _interviewStateController = Get.find<InterviewStateController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InterviewStateController>(
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
              "Interview",
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
                          "Send your feedback to your applicant. You can also write them a letter of reference at the end of their contract.",
                          style: TextStyle(
                            color: Color(0xff5E5E5E),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          maxLines: 10,
                          minLines: 6,
                          keyboardType: TextInputType.multiline,
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
                            hintText: "Feedback",
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
                            controller.updateFeedbacktext(value);
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
                            hintText: "Reference Letter",
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
                            controller.updateReferenceLetterText(value);
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
                            (controller.feedBackText == "")?
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
                            controller.sendFeedBack(context, ID);
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
                            "Send",
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