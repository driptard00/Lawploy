import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/paymentStateController.dart';
import 'package:lawploy_app/screens/Main/PAYMENT/tabViews/inflowView.dart';
import 'package:lawploy_app/screens/Main/PAYMENT/tabViews/outflowView.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});

  final PaymentStateController _paymentStateController = Get.put(PaymentStateController());

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _paymentStateController.getAllPayments();
    });
    
    return GetBuilder<PaymentStateController>(
        builder: (controller) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
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
                  "Payment",
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
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    Container(
                      height: 47,
                      width: Get.width,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: const Color(0xff767680).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: TabBar(
                        indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        unselectedLabelColor: const Color(0xff868686),
                        labelColor: const Color(0xff03132B),
                        tabs: const [
                          Tab(
                            text: "Inflow",
                          ),
                          Tab(
                            text: "Outflow",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Expanded(
                      child: TabBarView(
                        children: [
                          InflowView(),
                          OutflowView()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}