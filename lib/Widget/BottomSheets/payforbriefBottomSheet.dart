import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:lawploy_app/Widget/Buttons/normalButtons.dart';
import 'package:lawploy_app/controllers/lawyerStateController.dart';
import 'package:lawploy_app/models/lawyerModel.dart';
import 'package:lawploy_app/models/other_lawyers_model.dart';
import 'package:lawploy_app/services/flutter_wave/flutter_wave_service.dart';

import '../../routes/app_route_names.dart';

class PayForBriefBottomSheet {
  static showPayForBriefBottomSheet (OtherLawyer otherLawyer, Lawyer lawyer, TextEditingController amountController,BuildContext context) {
    Get.bottomSheet(
      GetBuilder<LawyerStateController>(
        builder: (controller) {
          return Container(
            height: 280,
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white
            ),
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
                const Row(
                  children:  [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Input Agreed Amount",
                        style: TextStyle(
                          color: Color(0xff03132B),
                          fontSize: 18,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
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
                  onChanged: (value) {
                    controller.updateMinimumAmount(value);
                  },
                ),
                const SizedBox(height: 30,),

                SizedBox(
                  height: 50,
                  width: Get.width,
                  child: TextButton(
                    onPressed: (){
                      (int.parse(amountController.text) < controller.otherLawyer.briefMinAmount!)?
                      Fluttertoast.showToast(
                      msg: "Amount must not be less than ${controller.otherLawyer.briefMinAmount!}",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0)
                      :
                      Get.toNamed(
                        paymentSummaryScreen,
                        arguments: {
                          "name": "${controller.lawyer.firstName} ${controller.lawyer.lastName}",
                          "phone": controller.lawyer.phoneNumber,
                          "email": controller.lawyer.email,
                          "amount": int.parse(amountController.text),
                          "auth": controller.lawyer.auth!,
                          "auth2": controller.otherLawyer.auth!,
                        }
                      );
                    }, 
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff041C40),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    child: (controller.isPayLoading)?
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                    :
                    const Text(
                      "Proceed",
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "CircularStdMedium"
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
      )
    );
  }
}