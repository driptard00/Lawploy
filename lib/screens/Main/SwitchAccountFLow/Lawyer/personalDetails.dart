import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/Widget/Buttons/normalButtons.dart';
import 'package:lawploy_app/Widget/TextHeaders/textHeaders.dart';
import 'package:lawploy_app/controllers/authStateController.dart';
import 'package:lawploy_app/controllers/lawyerStateController.dart';
import 'package:lawploy_app/routes/app_route_names.dart';

class SwitchPersonalDetailsScreen extends StatelessWidget {
  SwitchPersonalDetailsScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LawyerStateController _lawyerStateController = Get.put(LawyerStateController());
final AuthStateController _authStateController = Get.find<AuthStateController>();

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
                            TextHeaders.textHeaders("Personal Details"),
                            const SizedBox(height: 10,),
                            const Text(
                              "Fill in the details below",
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
                                labelText: "First Name",
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
                              validator: ValidationBuilder().build(),
                              onChanged: (value) {
                                controller.updateFirstname(value);
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
                                labelText: "Middle Name",
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
                              validator: ValidationBuilder().build(),
                              onChanged: (value) {
                                controller.updateMiddlename(value);
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
                                labelText: "Last Name",
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
                              validator: ValidationBuilder().build(),
                              onChanged: (value) {
                                controller.updateLastname(value);
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
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    controller: controller.codeController,
                                    onTap: () {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      showCountryPicker(
                                        context: context, 
                                        showPhoneCode: true,
                                        onSelect:(Country country) {
                                          controller.updateCodeController(country.flagEmoji + country.phoneCode);
                                        },
                                      );
                                    },
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
                                      hintText: "e.g +234"
                                    ),
                                    validator: ValidationBuilder().build(),
                                    onChanged: (value) {
                                    },
                                  ),
                                ),
                                const SizedBox(width: 15,),
                                Expanded(
                                  flex: 7,
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
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
                                      labelText: "Phone Number",
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
                                    validator: ValidationBuilder().build(),
                                    onChanged: (value) {
                                      controller.updatePhoneNumber(value);
                                    },
                                  ),
                                ),
                              ],
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
                            Get.toNamed(workDetailsLawyer);
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