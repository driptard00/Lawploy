import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/authStateController.dart';
import 'package:lawploy_app/controllers/companyStateController.dart';
import 'package:lawploy_app/controllers/interview_state_controller.dart';
import 'package:lawploy_app/controllers/privateStateController.dart';


class CompanySendInterviewInviteScreen extends StatelessWidget {
  CompanySendInterviewInviteScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PrivateStateController _privateStateController = Get.find<PrivateStateController>();
  final InterviewStateController _interviewStateController = Get.find<InterviewStateController>();
  final id = Get.arguments["id"];
  final auth = Get.arguments["auth"];

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _privateStateController.getSingleJob(id);
    });

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
              "Interview Details",
              style: TextStyle(
                color: Color(0xff03132B),
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            centerTitle: true,
          ),
          body: (controller.isLoading)?
          Center(
            child: SpinKitThreeBounce(
              color: Color(0xff041C40),
            ),
          )
              :
          Container(
            height: Get.height,
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      flex: 9,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20,),
                            const Text(
                              "Let’s create your job post",
                              style: TextStyle(
                                color: Color(0xff5E5E5E),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 20,),
                            TextFormField(
                              onTap: (){
                                FocusScope.of(context).requestFocus(FocusNode());
                                controller.showDateTimePicker(context);
                              },
                              controller: controller.dateController,
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
                                labelText: "Date of interview",
                                labelStyle: const TextStyle(
                                  color: Color(0xffAFAFAF),
                                  fontSize: 16
                                ),
                                floatingLabelStyle: const TextStyle(
                                  color: Color(0xff041C40)
                                ),
                                suffixIcon: const Icon(
                                  Iconsax.calendar_1,
                                  size: 24,
                                ),
                                suffixIconColor: const Color(0xff041C40)
                              ),
                              cursorColor: const Color(0xff041C40),
                              onChanged: (value) {
                              },
                            ),
                            const SizedBox(height: 20,),
                            TextFormField(
                              onTap: (){
                                FocusScope.of(context).requestFocus(FocusNode());
                                // _interviewStateController.(context);
                              },
                              controller: controller.timeController,
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
                                labelText: "Time of interview",
                                labelStyle: const TextStyle(
                                  color: Color(0xffAFAFAF),
                                  fontSize: 16
                                ),
                                floatingLabelStyle: const TextStyle(
                                  color: Color(0xff041C40)
                                ),
                                suffixIcon: const Icon(
                                  Iconsax.timer_1,
                                  size: 24,
                                ),
                                suffixIconColor: const Color(0xff041C40)
                              ),
                              cursorColor: const Color(0xff041C40),
                              onChanged: (value) {
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: SizedBox(
                          height: 50,
                          width: Get.width,
                          child: TextButton(
                            onPressed: () {
                              controller.sendInterviewInvite(context, auth);
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
                              "Send Invitation",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}