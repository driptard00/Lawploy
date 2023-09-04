import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/Widget/PopUps/otpPopUp.dart';
import 'package:lawploy_app/controllers/authStateController.dart';
import 'package:lawploy_app/routes/app_route_names.dart';

import '../../../Widget/Buttons/normalButtons.dart';
import '../../../Widget/TextHeaders/textHeaders.dart';

class ProfileAvailabilityScreen extends StatelessWidget {
  ProfileAvailabilityScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthStateController _authStateController = Get.put(AuthStateController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthStateController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 20,),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const Icon(
                                    Iconsax.arrow_left,
                                    size: 25,
                                    color: Color(0xff041C40),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            TextHeaders.textHeaders("Would you like to make your profile available for companies, law firm and recruiters using our platform to employ lawyers?"),
                            const SizedBox(height: 30,),
                            Flexible(
                              child: Container(
                                width: Get.width,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xffCFCFCF)
                                  )
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    RadioListTile(
                                      controlAffinity: ListTileControlAffinity.trailing,
                                      title: Text(
                                        controller.availabilityOptions[0],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff0E0E0E)
                                        ),
                                      ),
                                      value: controller.availabilityOptions[0], 
                                      groupValue: controller.selectedAvailability, 
                                      onChanged: (value){
                                        controller.updateAvailability(value);
                                      },
                                      activeColor: const Color(0xffD3A518),
                                    ),
                                    const Divider(
                                      color: Color(0xffCFCFCF),
                                    ),
                                    RadioListTile(
                                      controlAffinity: ListTileControlAffinity.trailing,
                                      title: Text(
                                        controller.availabilityOptions[1],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff0E0E0E)
                                        ),
                                      ),
                                      value: controller.availabilityOptions[1], 
                                      groupValue: controller.selectedAvailability, 
                                      onChanged: (value){
                                        controller.updateAvailability(value);
                                      },
                                      activeColor: const Color(0xffD3A518),
                                    ),
                                  ]
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: NormalButton.normalButton(
                          (){
                            Get.toNamed(loginScreen);
                          },
                          "Next"
                        )
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