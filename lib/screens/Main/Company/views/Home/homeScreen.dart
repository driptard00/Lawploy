import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/appStateController.dart';
import 'package:lawploy_app/controllers/authStateController.dart';
import 'package:lawploy_app/controllers/companyStateController.dart';
import 'package:lawploy_app/routes/app_route_names.dart';
import 'package:lawploy_app/screens/Main/Company/views/Home/HomeTabView/allTabViews.dart';
import '../../../../../controllers/notification_state_controller.dart';
import 'HomeTabView/ardTabView.dart';
import 'HomeTabView/corporateTabView.dart';
import 'HomeTabView/financeTabView.dart';
import 'HomeTabView/litigationTabView.dart';
import 'HomeTabView/oilAndGas.dart';


class CompanyHomeScreen extends StatelessWidget {
  CompanyHomeScreen({super.key});

  final AuthStateController _authStateController =
      Get.put(AuthStateController());

  final NotificationStateController _notificationStateController = Get.put(NotificationStateController());
  final CompanyStateController _companyStateController = Get.put(CompanyStateController());

  @override
  Widget build(BuildContext context) {

    return GetBuilder<AppStateController>(
      builder: (controller) {
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
                                      flex: 8,
                                      child: Text(
                                        "Find the Best Lawyer in the Field",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontFamily: "CabinetBold"),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                Get.toNamed(companyinterviewScreen);
                                              },
                                              child: Badge(
                                                isLabelVisible: (controller.sent.isNotEmpty || controller.applicants.isNotEmpty)?
                                                true
                                                :
                                                false,
                                                label: Text(
                                                  ((controller.sent.length + controller.applicants.length) > 9)?
                                                  "9+"
                                                  :
                                                  "${controller.sent.length + controller.applicants.length}",
                                                  style: const TextStyle(
                                                    color: Colors.white
                                                  ),
                                                ),
                                                child: const Icon(
                                                  Iconsax.maximize_2,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10,),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                Get.toNamed(
                                                  notificationScreen,
                                                  arguments: {
                                                    "type": _companyStateController.corporation.type
                                                  }
                                                );
                                              },
                                              child: Badge(
                                                isLabelVisible: (controller.ureadList.isNotEmpty)?
                                                true
                                                :
                                                false,
                                                label: Text(
                                                  (controller.ureadList.length > 9)?
                                                  "9+"
                                                  :
                                                  controller.ureadList.length.toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white
                                                  ),
                                                ),
                                                child: const Icon(
                                                  Iconsax.notification,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
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
                                          fontSize: 16
                                        )
                                      ),
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
                          "Top Practice Areas",
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
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Employment",
                              style: TextStyle(
                                color: Color(0xff0E0E0E),
                                fontSize: 16,
                                fontFamily: "CabinetBold"
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(companyPostJobOfferScreen);
                              },
                              child: const Text(
                                "Post job offers",
                                style: TextStyle(
                                  color: Color(0xffD3A518),
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20,),
                         Expanded(
                          child: TabBarView(
                            children: [
                              CompanyAllViews(),
                              CompanyArdViews(),
                              CompanyCorporateViews(),
                              CompanyFinanceViews(),
                              CompanyLitigationViews(),
                              CompanyOAGViews(),
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
