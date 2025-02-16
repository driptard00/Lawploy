import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../Widget/BottomSheets/payforbriefBottomSheet.dart';
import '../../../controllers/paymentStateController.dart';

class PaymentSummaryScreen extends StatelessWidget {
  PaymentSummaryScreen({super.key});

  final PaymentStateController _paymentStateController = Get.put(PaymentStateController());
  final name = Get.arguments["name"];
  final phone = Get.arguments["phone"];
  final email = Get.arguments["email"];
  final amount = Get.arguments["amount"];
  final auth = Get.arguments["auth"];
  final auth2 = Get.arguments["auth2"];

  var format = NumberFormat('#,##0');


  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentStateController>(
        builder: (controller) {
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
                "Payment Summary",
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
              child: Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "NGN${format.format(amount)}",
                          style: const TextStyle(
                              color: Color(0xff0E0E0E),
                              fontSize: 24,
                              fontWeight: FontWeight.bold

                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Payment Fee:",
                                style: const TextStyle(
                                  color: Color(0xff5E5E5E),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "NGN${format.format(amount)}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    // fontFamily: "CircularStdBold",
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Commission Fee:",
                                style:  TextStyle(
                                  color: Color(0xff5E5E5E),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "NGN${format.format(controller.updateCommissinFee(amount))}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    // fontFamily: "CircularStdBold",
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          color: Color(0xffCFCFCF),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Total Fee:",
                                style: TextStyle(
                                  color: Color(0xff5E5E5E),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "NGN${format.format(controller.totalFee(amount, controller.updateCommissinFee(amount)))}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    // fontFamily: "CircularStdBold",
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        Container(
                          height: 104,
                          width: Get.width,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: const Color(0xffF6EDD1),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "PLEASE NOTE",
                                style:  TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff363636),
                                  fontSize: 14,
                                ),
                              ),
                               SizedBox(
                                height: 10,
                              ),
                              Text(
                                "You’ll be charged 10% commission fee on payment fee",
                                style:  TextStyle(
                                  color: Color(0xff5E5E5E),
                                  fontSize: 14,
                                ),
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: Get.width,
                            child: TextButton(
                              onPressed: () {
                                controller.paymentInit(
                                  context, 
                                  name,
                                  phone,
                                  email,
                                  controller.totalFee(amount, controller.updateCommissinFee(amount)),
                                  auth,
                                  auth2
                                );
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xff041C40),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                              ),
                              child: (controller.isLoading)?
                                const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                                :
                               Text(
                                "Pay Now",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}