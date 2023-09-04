import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/Widget/Buttons/normalButtons.dart';
import 'package:lawploy_app/controllers/appStateController.dart';
import 'package:lawploy_app/controllers/privateStateController.dart';

import '../../../../../Widget/BottomSheets/PrivateUploadProfilePicture.dart';

class PIEditProfileScreen extends StatelessWidget {
  PIEditProfileScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AppStateController _appStateController = Get.put(AppStateController());

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
      body: GetBuilder<PrivateStateController>(
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
                            (controller.privateIndividual.image != null)?
                            NetworkImage(controller.privateIndividual.image!)
                            :
                            const  AssetImage("images/profileAvatar.png") as ImageProvider
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: InkWell(
                            onTap: () {
                              PrivateUploadProfilePicture.showPrivateUploadProfilePicture();
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
                                    "Personal details",
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
                            controller: controller.firstnameController,
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
                                fontSize: 16
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
                            controller: controller.middlenameController,
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
                                fontSize: 16
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
                            controller: controller.lastnameController,
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
                                fontSize: 16
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
                            controller: controller.emailAddressController,
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
                                fontSize: 16
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
                          const SizedBox(
                            height: 20,
                          ),
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
                                  controller: controller.phonenumberController,
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
                                      fontSize: 16
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
                        ]
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: (controller.isLoading)?
                      const SpinKitThreeBounce(
                        color: Color(0xff041C40),
                      )
                      :
                      NormalButton.normalButton(
                        () {
                          (_formKey.currentState!.validate())?
                          controller.updatePrivateProfile()
                          :
                          AutovalidateMode.disabled;
                        },
                        "Save"
                      )
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