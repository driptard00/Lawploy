import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/authStateController.dart';
import 'package:nigerian_states_and_lga/nigerian_states_and_lga.dart';

class PISwitchAccountScreen extends StatelessWidget {
  PISwitchAccountScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthStateController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Iconsax.arrow_left,
                color: Color(0xff041C40),
              ),
            ),
            backgroundColor: const Color(0xffF9F9F9),
            elevation: 1,
            title: const Text(
              "Switch Account",
              style: TextStyle(
                color: Color(0xff03132B),
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            centerTitle: true,
          ),
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
                            const Text(
                              "Fill in the details below to get hired by lawfirms, recuritment companies",
                              style: TextStyle(
                                color: Color(0xff5E5E5E),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 20,),
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
                                  fontSize: 16
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
                                  fontSize: 16
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
                            DropdownButtonFormField<dynamic>(
                              items: controller.practiceAreas.map((areas) {
                                return DropdownMenuItem(
                                  value: areas,
                                  child: Text(
                                    areas
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
                                labelText: "Practice Area",
                                labelStyle: const TextStyle(
                                  color: Color(0xffAFAFAF),
                                  fontSize: 16
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
                                  fontSize: 16
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
                            const SizedBox(height: 20,),
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
                                        fontSize: 16
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
                        child: SizedBox(
                          height: 50,
                          width: Get.width,
                          child: TextButton(
                            onPressed: () {
                              // Get.toNamed(lawyerprofileAvailabilityScreen);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xff041C40),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                            ),
                            child: const Text(
                              "Switch",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
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