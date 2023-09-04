import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/Widget/PopUps/otpPopUp.dart';
import 'package:lawploy_app/controllers/authStateController.dart';
import 'package:lawploy_app/routes/app_route_names.dart';

import '../../Widget/Buttons/normalButtons.dart';
import '../../Widget/TextHeaders/textHeaders.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

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
                            TextHeaders.textHeaders("Your Email"),
                            const SizedBox(height: 10,),
                            const Text(
                              "Enter your email address for verfication",
                              style: TextStyle(
                                color: Color(0xff5E5E5E),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 30,),
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
                                labelText: "Email Address",
                                labelStyle: const TextStyle(
                                  color: Color(0xffAFAFAF),
                                  fontSize: 16,
                                  fontFamily: "CabinetMedium"
                                ),
                                floatingLabelStyle: const TextStyle(
                                  color: Color(0xff041C40)
                                )
                              ),
                              cursorColor: const Color(0xff041C40),
                              validator: ValidationBuilder().email().build(),
                              onChanged: (value) {
                                controller.updateEmail(value);
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
                                labelText: "Password",
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
                            const SizedBox(height: 10,),
                            const Text(
                              "At least 9 characters, containing a letter, a number and a special character.",
                              style: TextStyle(
                                color: Color(0xff0E0E0E),
                                fontSize: 14,
                              ),
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
                          () {
                            (_formKey.currentState!.validate())?
                            controller.registerUser(context)
                            :
                            AutovalidateMode.disabled;
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