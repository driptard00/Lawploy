import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/authStateController.dart';
import 'package:lawploy_app/controllers/interview_state_controller.dart';

import '../../Widget/BottomSheets/inviteForInterViewBottom.dart';
import '../../Widget/BottomSheets/postJobsBottomSheet.dart';

class InviteForInterviewScreen extends StatelessWidget {
  InviteForInterviewScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final InterviewStateController _interviewStateController = Get.put(InterviewStateController());
  final recieverAuth = Get.arguments["recieverAuth"];

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _interviewStateController.readJson();
    });

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
          "Interview Invitation",
          style: TextStyle(
            color: Color(0xff03132B),
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<InterviewStateController>(
        builder: (controller) {
          return Form(
            key: _formKey,
            child: Container(
              height: Get.height,
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 9,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Share the details of the company and interview with the applicants",
                            style: TextStyle(
                              color: Color(0xff03132B),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                      radius: 50,
                                      backgroundImage: (controller.selectedImage != null)?
                                      FileImage(controller.selectedImage!)
                                          :
                                      null
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: InkWell(
                                      onTap: (){
                                        InterviewInvitePhotoBottom.showInterviewInvitePhotoBottom();
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: const Color(0xffF9F9F9)
                                        ),
                                        child: const Icon(
                                          Iconsax.camera,
                                          color: Color(0xffD3A518),
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
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
                              labelText: "Name of the Company",
                              labelStyle: const TextStyle(
                                color: Color(0xffAFAFAF),
                                fontSize: 16
                              ),
                              floatingLabelStyle: const TextStyle(
                                color: Color(0xff041C40)
                              )
                            ),
                            cursorColor: const Color(0xff041C40),
                            validator: ValidationBuilder().build(),
                            onChanged: (value) {
                              controller.updateName(value);
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextFormField(
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
                              labelText: "Job Title",
                              labelStyle: const TextStyle(
                                color: Color(0xffAFAFAF),
                                fontSize: 16
                              ),
                              floatingLabelStyle: const TextStyle(
                                color: Color(0xff041C40)
                              )
                            ),
                            cursorColor: const Color(0xff041C40),
                            validator: ValidationBuilder().build(),
                            onChanged: (value) {
                              controller.updateJobTitle(value);
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
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
                              labelText: "Bio of the Company",
                              labelStyle: const TextStyle(
                                color: Color(0xffAFAFAF),
                                fontSize: 16
                              ),
                              floatingLabelStyle: const TextStyle(
                                color: Color(0xff041C40)
                              )
                            ),
                            cursorColor: const Color(0xff041C40),
                            validator: ValidationBuilder().build(),
                            onChanged: (value) {
                              controller.updateDescription(value);
                            },
                          ),
                          const SizedBox(height: 20,),
                          DropdownButtonFormField<dynamic>(
                            items: controller.positionTypes.map((eachType) {
                              return DropdownMenuItem(
                                value: eachType,
                                child: Text(
                                  eachType
                                ),
                              );
                            }).toList(),
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
                              labelText: "What type of position",
                              labelStyle: const TextStyle(
                                color: Color(0xffAFAFAF),
                                fontSize: 16
                              ),
                              floatingLabelStyle: const TextStyle(
                                color: Color(0xff041C40)
                              )
                            ),
                            onChanged: (value) {
                              controller.updatePositionType(value);
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
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
                              labelText: "Job Responsibilities",
                              labelStyle: const TextStyle(
                                color: Color(0xffAFAFAF),
                                fontSize: 16
                              ),
                              floatingLabelStyle: const TextStyle(
                                color: Color(0xff041C40)
                              )
                            ),
                            cursorColor: const Color(0xff041C40),
                            validator: ValidationBuilder().build(),
                            onChanged: (value) {
                              controller.updateResponsibilities(value);
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextFormField(
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
                              labelText: "Company’s website",
                              labelStyle: const TextStyle(
                                color: Color(0xffAFAFAF),
                                fontSize: 16
                              ),
                              floatingLabelStyle: const TextStyle(
                                color: Color(0xff041C40)
                              )
                            ),
                            cursorColor: const Color(0xff041C40),
                            onChanged: (value) {
                              controller.updateWebsite(value);
                            },
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: DropdownButtonFormField<dynamic>(
                                  isExpanded: true,
                                  items: controller.countries.map((country) {
                                    return DropdownMenuItem(
                                      value: country["name"],
                                      onTap: () {
                                        controller.updateStates(country["states"]);
                                      },
                                      child: Text(
                                        country["name"]
                                      ),
                                    );
                                  }).toList(),
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
                                    labelText: "Country",
                                    labelStyle: const TextStyle(
                                      color: Color(0xffAFAFAF),
                                      fontSize: 16
                                    ),
                                    floatingLabelStyle: const TextStyle(
                                      color: Color(0xff041C40)
                                    )
                                  ),
                                  onChanged: (value) {
                                    controller.updateCountry(value);
                                  },
                                ),
                              ),
                              const SizedBox(width: 15,),
                              Expanded(
                                flex: 1,
                                child: DropdownButtonFormField<dynamic>(
                                  isExpanded: true,
                                  items: controller.states.map((state) {
                                    return DropdownMenuItem(
                                      value: state["name"],
                                      child: Text(
                                        state["name"]
                                      ),
                                    );
                                  }).toList(),
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
                                    labelText: "State",
                                    labelStyle: const TextStyle(
                                      color: Color(0xffAFAFAF),
                                      fontSize: 16
                                    ),
                                    floatingLabelStyle: const TextStyle(
                                      color: Color(0xff041C40)
                                    )
                                  ),
                                  onChanged: (value) {
                                    controller.updateState(value);
                                  },
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
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
                                    labelText: "Date of Interview",
                                    labelStyle: const TextStyle(
                                      color: Color(0xffAFAFAF),
                                      fontSize: 16
                                    ),
                                    floatingLabelStyle: const TextStyle(
                                      color: Color(0xff041C40)
                                    ),
                                      prefixIcon: const Icon(
                                        Iconsax.calendar,
                                        color: Color(0xff041C40),
                                      )
                                  ),
                                  cursorColor: const Color(0xff041C40),
                                  validator: ValidationBuilder().build(),
                                  onChanged: (value) {
                                    controller.updateCountry(value);
                                  },
                                ),
                              ),
                              const SizedBox(width: 15,),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  onTap: (){
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    controller.displayTimePicker(context);
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
                                      labelText: "Time of Interview",
                                      labelStyle: const TextStyle(
                                          color: Color(0xffAFAFAF),
                                          fontSize: 16,
                                          fontFamily: "CabinetMedium"
                                      ),
                                      floatingLabelStyle: const TextStyle(
                                          color: Color(0xff041C40)
                                      ),
                                    prefixIcon: Icon(
                                      Iconsax.clock,
                                      color: Color(0xff041C40),
                                    )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                    child: Container(
                      child: SizedBox(
                          height: 50,
                          width: Get.width,
                          child: TextButton(
                            onPressed: () {
                              (_formKey.currentState!.validate())?
                              controller.sendInterviewInvite(context, recieverAuth)
                                  :
                              AutovalidateMode.disabled;
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xff041C40),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                            ),
                            child: (controller.isLoading)?
                            const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            :
                            const Text(
                              "Create",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                              ),
                            ),
                          ),
                        ),
                    ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}