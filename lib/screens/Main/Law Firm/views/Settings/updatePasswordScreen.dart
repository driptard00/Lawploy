import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/Widget/PopUps/otpPopUp.dart';
import 'package:lawploy_app/Widget/TextHeaders/textHeaders.dart';
import 'package:lawploy_app/controllers/authStateController.dart';

import '../../../../../Widget/Buttons/normalButtons.dart';
import '../../../../../controllers/lawfirmStateController.dart';


class LawFirmUpdatePassword extends StatelessWidget {
  LawFirmUpdatePassword({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LawFirmStateController _lawFirmStateController = Get.put(LawFirmStateController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LawFirmStateController>(
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
                              TextHeaders.textHeaders("Create New Password"),
                              const SizedBox(height: 10,),
                              const Text(
                                "Fill in the details to create a new password",
                                style: TextStyle(
                                  color: Color(0xff5E5E5E),
                                  fontSize: 16,
                                ),
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
                                    labelText: "New Password",
                                    labelStyle: const TextStyle(
                                        color: Color(0xffAFAFAF),
                                        fontSize: 16,
                                        fontFamily: "CabinetMedium"
                                    ),
                                    floatingLabelStyle: const TextStyle(
                                        color: Color(0xff041C40)
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.toggleHidePassword();
                                      },
                                      icon: Icon(
                                        (controller.hidePassword)?
                                        Iconsax.eye_slash
                                            :
                                        Iconsax.eye,
                                        size: 24,
                                      ),
                                    ),
                                    suffixIconColor: const Color(0xff041C40)
                                ),
                                cursorColor: const Color(0xff041C40),
                                validator: ValidationBuilder().minLength(9).build(),
                                onChanged: (value) {
                                  controller.updatePassword(value);
                                },
                                obscureText: controller.hidePassword,
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
                                    labelText: "New Confirm Password",
                                    labelStyle: const TextStyle(
                                        color: Color(0xffAFAFAF),
                                        fontSize: 16,
                                        fontFamily: "CabinetMedium"
                                    ),
                                    floatingLabelStyle: const TextStyle(
                                        color: Color(0xff041C40)
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.toggleHidePassword();
                                      },
                                      icon: Icon(
                                        (controller.hidePassword)?
                                        Iconsax.eye_slash
                                            :
                                        Iconsax.eye,
                                        size: 24,
                                      ),
                                    ),
                                    suffixIconColor: const Color(0xff041C40)
                                ),
                                cursorColor: const Color(0xff041C40),
                                validator: ValidationBuilder().minLength(9).build(),
                                onChanged: (value) {
                                  controller.updateConfirmPassword(value);
                                },
                                obscureText: controller.hidePassword,
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
                                  (controller.password == controller.confirmPassword)?
                                  controller.updateLawFirmPassword(context)
                                      :
                                  Fluttertoast.showToast(
                                      msg: "Password does not match!",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                },
                                "Update"
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