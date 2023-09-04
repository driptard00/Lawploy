import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/screens/Main/SEARCH%20SCREEN/tab_views/company_tab_views.dart';
import 'package:lawploy_app/screens/Main/SEARCH%20SCREEN/tab_views/lawyers_tab_view.dart';
import '../../../Widget/BottomSheets/searchFilterBottomSheet.dart';
import '../../../controllers/searchStateController.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final SearchStateController _searchStateController = Get.put(SearchStateController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchStateController>(
      builder: (controller) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            body: Container(
              height: Get.height,
              width: Get.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 180,
                      width: Get.width,
                      color: const Color(0xff041C40),
                      child: SafeArea(
                        bottom: false,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              child: Image.asset(
                                "images/eclipse2.png",
                              ),
                            ),
                            Positioned(
                              right: 0,
                              left: 0,
                              bottom: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 8,
                                          child: TextFormField(
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                            filled: true,
                                            fillColor: Colors.white,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            prefixIcon: const Icon(
                                              Iconsax.search_normal,
                                              color: Color(0xffAFAFAF),
                                              size: 16,
                                            ),
                                            suffixIcon: InkWell(
                                              onTap: (){
                                                SearchFilterBottomSheet.showSearchFilterBottomSheet();
                                              },
                                              child: const Icon(
                                                Iconsax.menu_1,
                                                color: Color(0xffD3A518),
                                                size: 20,
                                              ),
                                            ),
                                            hintText: "Search for lawyer, companies...",
                                            hintStyle: const TextStyle(
                                              color: Color(0xffAFAFAF),
                                              fontSize: 16
                                            )
                                          ),
                                          onChanged: (value) {
                                            controller.updateSelectedPracticeArea(value);
                                            (value != "")?
                                            controller.searchForLawyers()
                                            :
                                            null;
                                          },
                                        ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                              onTap: (){
                                                Get.back();
                                              },
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const TabBar(
                                      unselectedLabelColor: Color(0xff868686),
                                      indicatorColor: Colors.white,
                                      tabs: [
                                        Tab(
                                          text: "Lawyer",
                                        ),
                                        Tab(
                                          text: "Companies",
                                        ),
                                      ]
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height - 180,
                      width: Get.width,
                      child: const TabBarView(
                        children: [
                          LawyerTabView(),
                          LawyerTabViewCompany()
                        ]
                      )
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