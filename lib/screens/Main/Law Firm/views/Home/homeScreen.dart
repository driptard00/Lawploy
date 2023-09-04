import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/authStateController.dart';
import 'package:lawploy_app/routes/app_route_names.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/views/Home/HomeTabView/allTabViews.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/views/Home/HomeTabView/ardTabView.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/views/Home/HomeTabView/corporateTabView.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/views/Home/HomeTabView/financeTabView.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/views/Home/HomeTabView/litigationTabView.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/views/Home/HomeTabView/oilAndGas.dart';

import '../../../../../controllers/lawfirmStateController.dart';


class LFHomeScreen extends StatelessWidget {
  LFHomeScreen({super.key});

  final AuthStateController _authStateController =
      Get.put(AuthStateController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LawFirmStateController>(builder: (controller) {
      return DefaultTabController(
        length: _authStateController.practiceAreas.length + 1,
        child: Scaffold(
          body: Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: const Color(0xff041C40),
                    child: SafeArea(
                      child: Stack(
                        children: [
                          Positioned(
                            child: Image.asset(
                              "images/eclipse2.png",
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Image.asset(
                              "images/eclipse1.png",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                      flex: 9,
                                      child: Text(
                                        "Find the Best Lawyer in the Field",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontFamily: "CabinetBold"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                              notificationScreen,
                                              arguments: {
                                                "type": controller.lawFirm.type
                                              }
                                          );
                                        },
                                        child: Icon(
                                          Iconsax.notification,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                TextFormField(
                                                                      onTap: () {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      Get.toNamed(searchScreen);
                                    },
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: InputBorder.none,
                                      prefixIcon: const Icon(
                                        Iconsax.search_normal,
                                        color: Color(0xffAFAFAF),
                                        size: 16,
                                      ),
                                      suffixIcon: const Icon(
                                        Iconsax.menu_1,
                                        color: Color(0xffD3A518),
                                        size: 20,
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                      labelText: "Search for lawyer",
                                      labelStyle: const TextStyle(
                                          color: Color(0xffAFAFAF),
                                          fontSize: 16)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Practice Area",
                          style: TextStyle(
                              color: Color(0xff03132B),
                              fontSize: 16,
                              fontFamily: "CabinetBold"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TabBar(
                            unselectedLabelColor: const Color(0xff868686),
                            indicator: BoxDecoration(
                                color: const Color(0xff041C40),
                                borderRadius: BorderRadius.circular(10)),
                            isScrollable: true,
                            tabs: const [
                              Tab(
                                text: "All",
                              ),
                              Tab(
                                text: "Alternative Dispute Resolution (ARD)",
                              ),
                              Tab(
                                text: "Corporate",
                              ),
                              Tab(
                                text: "Finance",
                              ),
                              Tab(
                                text: "Litigation",
                              ),
                              Tab(
                                text: "Oil and Gas",
                              ),
                            ]),
                        const Expanded(
                          child: TabBarView(
                            children: [
                              LFAllViews(),
                              LFArdView(),
                              LFCorporateView(),
                              LFFinanceView(),
                              LFLitigationView(),
                              LFOilAndGasView()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
