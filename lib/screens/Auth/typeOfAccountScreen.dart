import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/authStateController.dart';
import 'package:lawploy_app/routes/app_route_names.dart';

import '../../Widget/Buttons/normalButtons.dart';
import '../../Widget/TextHeaders/textHeaders.dart';

class TypeOfAccountScreen extends StatelessWidget {
  TypeOfAccountScreen({super.key});

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
                          mainAxisSize: MainAxisSize.min,
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
                            TextHeaders.textHeaders("Type of Account"),
                            const SizedBox(height: 10,),
                            const Text(
                              "Select your preferred sign up mode",
                              style: TextStyle(
                                color: Color(0xff5E5E5E),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 30,),
                            Flexible(
                              child: Container(
                                width: Get.width,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xffCFCFCF)
                                  )
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    RadioListTile(
                                      controlAffinity: ListTileControlAffinity.trailing,
                                      // contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        controller.typeOptions[0],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff0E0E0E)
                                        ),
                                      ),
                                      value: controller.typeOptions[0], 
                                      groupValue: controller.selectedTypeOption, 
                                      onChanged: (value){
                                        controller.updateSelectedOption(value);
                                      },
                                      activeColor: const Color(0xffD3A518),
                                      
                                    ),
                                    const Divider(
                                      color: Color(0xffCFCFCF),
                                    ),
                                    RadioListTile(
                                      controlAffinity: ListTileControlAffinity.trailing,
                                      // contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        controller.typeOptions[1],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff0E0E0E)
                                        ),
                                      ),
                                      value: controller.typeOptions[1], 
                                      groupValue: controller.selectedTypeOption, 
                                      onChanged: (value){
                                        controller.updateSelectedOption(value);
                                      },
                                      activeColor: const Color(0xffD3A518),
                                    ),
                                    const Divider(
                                      color: Color(0xffCFCFCF),
                                    ),
                                    RadioListTile(
                                      controlAffinity: ListTileControlAffinity.trailing,
                                      // contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        controller.typeOptions[2],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff0E0E0E)
                                        ),
                                      ),
                                      value: controller.typeOptions[2], 
                                      groupValue: controller.selectedTypeOption, 
                                      onChanged: (value){
                                        controller.updateSelectedOption(value);
                                      },
                                      activeColor: const Color(0xffD3A518),
                                    ),
                                    const Divider(
                                      color: Color(0xffCFCFCF),
                                    ),
                                    RadioListTile(
                                      controlAffinity: ListTileControlAffinity.trailing,
                                      // contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        controller.typeOptions[3],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff0E0E0E)
                                        ),
                                      ),
                                      value: controller.typeOptions[3], 
                                      groupValue: controller.selectedTypeOption, 
                                      onChanged: (value){
                                        controller.updateSelectedOption(value);
                                      },
                                      activeColor: const Color(0xffD3A518),
                                    ),
                                  ]
                                ),
                              ),
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
                            (controller.selectedTypeOption == "Lawyer")?
                              Get.toNamed(lawyerpersonalDetailsScreen)
                              :
                              (controller.selectedTypeOption == "Law Firm")?
                              Get.toNamed(lawFirmDetails)
                              :
                              (controller.selectedTypeOption == "Corporation")?
                              Get.toNamed(comapanyDetailsScreen)
                              :
                              (controller.selectedTypeOption == "Private Individual")?
                              Get.toNamed(pipersonalDetailsScreen)
                              :
                              Fluttertoast.showToast(
                                msg: "User type needed",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                              );
                          }, 
                          "Next"
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