import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nigerian_states_and_lga/nigerian_states_and_lga.dart';
import '../../controllers/searchStateController.dart';
import '../Buttons/normalButtons.dart';

class SearchFilterBottomSheet {
  static showSearchFilterBottomSheet () {
    Get.bottomSheet(
      GetBuilder<SearchStateController>(
        builder: (controller) {
          return Container(
            height: 500,
            width: Get.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xffE7E7E7),
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    "Filter",
                    style: TextStyle(
                      color: Color(0xff03132B),
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: 250,
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffE7E7E7)
                        ),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    "Specialization",
                                    style: TextStyle(
                                      color: Color(0xff03132B),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3,),
                                const Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: const Divider(
                                    color: Color(0xffE7E7E7)
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: ListView.builder(
                                    itemCount: controller.practiceAreas.length,
                                    itemBuilder: (context, index) {
                                      return RadioListTile(
                                        controlAffinity: ListTileControlAffinity.trailing,
                                        value: controller.practiceAreas[index], 
                                        groupValue: controller.selectedPracticeArea, 
                                        onChanged:(value) {
                                          controller.updateSelectedPracticeArea(value);
                                        },
                                        title: Text(
                                          controller.practiceAreas[index]
                                        ),
                                        activeColor: const Color(0xffD3A518),
                                      );
                                    }
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
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
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
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
                        ),
                      ]
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: (controller.country == "Nigeria" || controller.country == "")?
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
                  ),
                  const SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: 
                    NormalButton.normalButton(
                      (){
                        // (_formKey.currentState!.validate())?
                        controller.searchForLawyers();
                        Get.back();
                        // :
                        // AutovalidateMode.disabled;
                      },
                      "Apply Filter"
                    ),
                  )
                
                ],
              ),
            ),
          );
        }
      ),
      isScrollControlled: true
    );
  }
}