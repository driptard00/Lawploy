import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/Widget/PopUps/otpPopUp.dart';
import 'package:lawploy_app/controllers/authStateController.dart';
import 'package:lawploy_app/routes/app_route_names.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../Widget/Buttons/normalButtons.dart';
import '../../Widget/TextHeaders/textHeaders.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen ({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthStateController _authStateController = Get.find<AuthStateController>();

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _authStateController.startTimer();
    },);

    return GetBuilder<AuthStateController>(
      builder: (controller) {
        return Scaffold(
          body: LoadingOverlay(
            isLoading: controller.isSendLoading,
            color: Colors.black,
            progressIndicator: const CircularProgressIndicator(
              color: Color(0xff041C40),
            ),
            child: Container(
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
                              TextHeaders.textHeaders("OTP Verification"),
                              const SizedBox(height: 10,),
                              const Text(
                                "Enter the 4 digit OTP code sent to your email",
                                style: TextStyle(
                                  color: Color(0xff5E5E5E),
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 30,),
                              PinCodeTextField(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                appContext: context,
                                length: 4,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(10),
                                  activeFillColor: Colors.white,
                                  inactiveFillColor: Colors.white,
                                  inactiveColor: const Color(0xffCFCFCF),
                                  fieldHeight: 45,
                                  fieldWidth: 50,
                                  selectedFillColor: const Color(0xff0E0E0E),
                                  selectedColor: const Color(0xff0E0E0E),
                                  activeColor: const Color(0xff0E0E0E)
                                ),
                                validator: (value) {
                                  if(value == "") {
                                    return "Please fill out field";
                                  } else{
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  controller.updateOtp(value);
                                },
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  (controller.timerIsDone)?
                                  TextButton(
                                    onPressed: (){
                                      controller.resendSignInOtp();
                                    }, 
                                    child: const Text(
                                    "Resend code",
                                    style: TextStyle(
                                      color: Color(0xff041C40),
                                      fontSize: 16,
                                      fontFamily: "CircularStdBold"
                                    ),
                                  ),
                                  )
                                  :
                                  Text(
                                    "Resend code in: ${controller.remainingSeconds.toString()}s",
                                    style: const TextStyle(
                                      color: Color(0xff5E5E5E),
                                      fontSize: 16,
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
                          child: (controller.isLoading)?
                          const SpinKitThreeBounce(
                            color: Color(0xff041C40),
                          )
                          :
                          NormalButton.normalButton(
                            (){
                              (_formKey.currentState!.validate())?
                              controller.verifyRegistrationOtp(context)
                              :
                              AutovalidateMode.disabled;
                            },
                            "Verify"
                          )
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}