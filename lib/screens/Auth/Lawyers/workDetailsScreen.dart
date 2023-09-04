import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/authStateController.dart';
import 'package:lawploy_app/controllers/lawyerStateController.dart';
import 'package:nigerian_states_and_lga/nigerian_states_and_lga.dart';

import '../../../Widget/BottomSheets/practiceArea.dart';
import '../../../Widget/Buttons/normalButtons.dart';
import '../../../Widget/TextHeaders/textHeaders.dart';
import '../../../routes/app_route_names.dart';

class WorkDetailsScreen extends StatelessWidget {
  WorkDetailsScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LawyerStateController _lawyerStateController = Get.find<LawyerStateController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LawyerStateController>(
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
                            TextHeaders.textHeaders("Work Details"),
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
                              keyboardType: TextInputType.multiline,
                              maxLines: 6,
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
                                labelText: "Brief Description",
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
                                controller.updateBriefDescription(value);
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
                                labelText: "Minimum amount for a brief",
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
                                controller.updateMinimumAmount(value);
                              },
                            ),
                            const SizedBox(height: 20,),
                            TextFormField(
                              onTap: () {
                                FocusScope.of(context).requestFocus(FocusNode());
                                PracticeAreas.showPracticeAreas();
                              },
                              controller: controller.practiceAreaController,
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
                                labelText: "Practice Area",
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
                                controller.updateSelectedPracticeArea(value);
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
                                labelText: "Year of Call",
                                labelStyle: const TextStyle(
                                  color: Color(0xffAFAFAF),
                                  fontSize: 16,
                                  fontFamily: "CabinetMedium"
                                ),
                                floatingLabelStyle: const TextStyle(
                                  color: Color(0xff041C40)
                                )
                              ),
                              onChanged: (value) {
                                controller.updateYearOfCall(value);
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
                                labelText: "Country",
                                labelStyle: const TextStyle(
                                  color: Color(0xffAFAFAF),
                                  fontSize: 16,
                                  fontFamily: "CabinetMedium"
                                ),
                                floatingLabelStyle: const TextStyle(
                                  color: Color(0xff041C40)
                                )
                              ),
                              onChanged: (value) {
                                controller.updateCountry(value);
                              },
                            ),
                            const SizedBox(height: 20,),
                            (controller.country == "Nigeria" || controller.country == "")?
                            Row(
                              children: [
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
                                        fontSize: 16,
                                        fontFamily: "CabinetMedium"
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
                                const SizedBox(width: 15,),
                                Expanded(
                                  flex: 1,
                                  child: DropdownButtonFormField<dynamic>(
                                    isExpanded: true,
                                    items: NigerianStatesAndLGA.getAllNigerianLGAs()
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
                                      labelText: "LGA",
                                      labelStyle: const TextStyle(
                                        color: Color(0xffAFAFAF),
                                        fontSize: 16,
                                        fontFamily: "CabinetMedium"
                                      ),
                                      floatingLabelStyle: const TextStyle(
                                        color: Color(0xff041C40)
                                      )
                                    ),
                                    onChanged: (value) {
                                      controller.updateLGA(value);
                                    },
                                  ),
                                ),
                              ],
                            )
                            :
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
                                      labelText: "State",
                                      labelStyle: const TextStyle(
                                        color: Color(0xffAFAFAF),
                                        fontSize: 16,
                                        fontFamily: "CabinetMedium"
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
                                const SizedBox(width: 15,),
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
                                      labelText: "LGA/Region",
                                      labelStyle: const TextStyle(
                                        color: Color(0xffAFAFAF),
                                        fontSize: 16,
                                        fontFamily: "CabinetMedium"
                                      ),
                                      floatingLabelStyle: const TextStyle(
                                        color: Color(0xff041C40)
                                      )
                                    ),
                                    onChanged: (value) {
                                      controller.updateLGA(value);
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
                        child: (controller.isLoading)?
                          const SpinKitThreeBounce(
                            color: Color(0xff041C40),
                          )
                        :
                        NormalButton.normalButton(
                          (){
                            (_formKey.currentState!.validate())?
                            controller.lawyerOnboarding()
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