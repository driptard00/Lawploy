import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/appStateController.dart';
import 'package:lawploy_app/controllers/lawfirmStateController.dart';

import '../../../../../Widget/BottomSheets/LawFirmUploadProfilePicture.dart';
import '../../../../../Widget/BottomSheets/PrivateUploadProfilePicture.dart';
import '../../../../../Widget/Buttons/normalButtons.dart';

class LFEditProfileScreen extends StatelessWidget {
  LFEditProfileScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
          "Profile",
          style: TextStyle(
            color: Color(0xff03132B),
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<LawFirmStateController>(
        builder: (controller) {
          return Form(
            key: _formKey,
            child: Container(
              height: Get.height,
              width: Get.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 9,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: (controller.selectedImage != null)?
                            FileImage(controller.selectedImage!)
                            :
                            (controller.lawFirm.image != null)?
                            NetworkImage(controller.lawFirm.image!)
                            :
                            const  AssetImage("images/profileAvatar.png") as ImageProvider
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: InkWell(
                            onTap: () {
                              LawFirmUploadProfilePicture.showLawFirmUploadProfilePicture();
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
                    const SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      child: Column(
                        children: [
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    "Work Details",
                                    style: TextStyle(
                                      color: Color(0xff03132B),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Color(0xffCFCFCF),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                            TextFormField(
                              controller: controller.companyNameController,
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
                                labelText: "Company's Name",
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
                                controller.updateCompanyName(value);
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
                                          controller.updateCodeController(country.phoneCode);
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
                                      hintText: "e.g +234",
                                    ),
                                    onChanged: (value) {
                                    },
                                  ),
                                ),
                                const SizedBox(width: 15,),
                                Expanded(
                                  flex: 7,
                                  child: TextFormField(
                                    controller: controller.companyPhoneNumberController,
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
                                      labelText: "Company's Phone Number",
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
                                      controller.updateCompanyPhoneNumber(value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            TextFormField(
                              controller: controller.companyAddressController,
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
                                labelText: "Company's Address",
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
                                controller.updateCompanyAddress(value);
                              },
                            ),
                            const SizedBox(height: 20,),
                            DropdownButtonFormField<dynamic>(
                              isExpanded: true,
                              // value: controller.countryController.text,
                              items: controller.countries.map((country) {
                                return DropdownMenuItem(
                                  value: country["name"],
                                  onTap: () {
                                    controller.updateStates(country["states"]);
                                  },
                                  child: Text(
                                    country["name"]
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
                                    isExpanded: true,
                                    // value: controller.stateController.text,
                                    items: controller.states.map((state) {
                                      return DropdownMenuItem(
                                        value: state["name"],
                                        child: Text(
                                          state["name"]
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
                                  child: TextFormField(
                                    controller: controller.lgaController,
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
                                    cursorColor: const Color(0xff041C40),
                                    validator: ValidationBuilder().build(),
                                    onChanged: (value) {
                                      controller.updateLGA(value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            TextFormField(
                              controller: controller.companyWebsiteController,
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
                                labelText: "Company's Website (Optional)",
                                labelStyle: const TextStyle(
                                  color: Color(0xffAFAFAF),
                                  fontSize: 16
                                ),
                                floatingLabelStyle: const TextStyle(
                                  color: Color(0xff041C40)
                                )
                              ),
                              cursorColor: const Color(0xff041C40),
                              // validator: ValidationBuilder().build(),
                              onChanged: (value) {
                                controller.updateCompanyWebsite(value);
                              },
                            ),
                              ],
                            ),
                          )
                        ],
                      ),
                      ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox(
                          height: 50,
                          width: Get.width,
                          child: (controller.isLoading)?
                          const SpinKitThreeBounce(
                            color: Color(0xff041C40),
                          )
                          :
                          NormalButton.normalButton(
                            (){
                              (_formKey.currentState!.validate())?
                              controller.editFirmProfile()
                              :
                              AutovalidateMode.disabled;
                            }, 
                            "Save"
                          )
                        ),
                    ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}