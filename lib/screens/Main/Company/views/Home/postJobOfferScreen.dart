import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/authStateController.dart';
import 'package:lawploy_app/controllers/jobStateController.dart';
import 'package:nigerian_states_and_lga/nigerian_states_and_lga.dart';

import '../../../../../Widget/BottomSheets/positionTypes.dart';
import '../../../../../Widget/BottomSheets/postJobsBottomSheet.dart';


class CompanyPostJobOfferScreen extends StatelessWidget {
  CompanyPostJobOfferScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final JobStateController _jobStateController = Get.put(JobStateController());

  @override
  Widget build(BuildContext context) {
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
              "Post Job Offers",
              style: TextStyle(
                color: Color(0xff03132B),
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            centerTitle: true,
          ),
          body: Form(
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
                            "Let’s create your job post",
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
                                        PostJobsPhotoBottom.showPostJobsPhotoBottom();
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
                          TextFormField(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              PositionTypes.showPositionTypes();
                            },
                            controller: controller.positionTypeController,
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
                                fontSize: 16,
                                fontFamily: "CabinetMedium"
                              ),
                              suffixIcon: const Icon(
                                Iconsax.arrow_down_1
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
                            validator: ValidationBuilder().build(),
                            onChanged: (value) {
                              controller.updateWebsite(value);
                            },
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
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
                                child: DropdownButtonFormField<dynamic>(
                                  key: const ValueKey('States'),
                                  items: NigerianStatesAndLGA.allStates
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
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
                              controller.createJobService(context)
                              :
                              AutovalidateMode.disabled;
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xff041C40),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                            ),
                            child: (controller.isLoading)?
                            const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white
                              ),
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
          )
        );
      }
    );
  }
}