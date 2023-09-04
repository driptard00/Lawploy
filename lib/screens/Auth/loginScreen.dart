import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/Widget/PopUps/otpPopUp.dart';
import 'package:lawploy_app/controllers/authStateController.dart';
import 'package:lawploy_app/routes/app_route_names.dart';

import '../../Widget/Buttons/normalButtons.dart';
import '../../Widget/TextHeaders/textHeaders.dart';
import '../../storage/secureStorage.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthStateController _authStateController = Get.put(AuthStateController());

  Future<void> getFcmToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? token = await messaging.getToken();
    print('FCM Token: $token');

    await LocalStorage().storeDeviceId(token!);
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getFcmToken();
      _authStateController.fetchEmailFromStorage();
    },);

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
                      flex: 1,
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
                            TextHeaders.textHeaders("Welcome Back"),
                            const SizedBox(height: 10,),
                            const Text(
                              "Enter your details below to log in",
                              style: TextStyle(
                                color: Color(0xff5E5E5E),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 30,),
                            TextFormField(
                              controller: controller.emailController,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(forgotPassword);
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: Color(0xffD3A518),
                                      fontSize: 14,
                                      fontFamily: "CabinetBold"
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
                        child: Column(
                          children: [
                            (controller.isLoading)?
                              const SpinKitThreeBounce(
                                color: Color(0xff041C40),
                              )
                            :
                            NormalButton.normalButton(
                              (){
                                (_formKey.currentState!.validate())?
                                controller.loginUser()
                                :
                                AutovalidateMode.disabled;
                              }, 
                              "Login"
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xff5E5E5E),
                                    fontSize: 16,
                                    fontFamily: "CabinetMedium"
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(signUpScreen);
                                  },
                                  child: const Text(
                                    "SignUp",
                                    style: TextStyle(
                                      color: Color(0xffD3A518),
                                      fontSize: 16,
                                      fontFamily: "CabinetBold"
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
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