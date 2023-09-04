import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:get/get.dart';
import 'package:lawploy_app/controllers/appStateController.dart';
import 'package:lawploy_app/routes/app_route_names.dart';

class OnboardingScreens extends StatelessWidget {
  OnboardingScreens({super.key});

  final AppStateController _appStateController = Get.put(AppStateController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppStateController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            height: Get.height,
            width: Get.width,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // color: Colors.red,
                    height: 500,
                    width: Get.width,
                    child: Swiper(
                      itemCount: controller.onboardingItems.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              controller.onboardingItems[controller.activeIndex]["image"]
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              controller.onboardingItems[controller.activeIndex]["title"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xff03132B),
                                fontSize: 22,
                                fontFamily: "CabinetBold"
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              controller.onboardingItems[controller.activeIndex]["subText"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xff5E5E5E),
                                fontSize: 14
                              ),
                            ),
                          ],
                        );
                      },
                      onIndexChanged: (index) {
                        controller.updateActiveIndex(index);
                      },
                    ),
                  ),
                  DotsIndicator(
                    dotsCount: controller.onboardingItems.length,
                    position: controller.activeIndex.toDouble(),
                    decorator: DotsDecorator(
                      size: const Size.square(7.0),
                      activeSize: const Size(27.0, 7.0),
                      activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      activeColor: const Color(0xffD3A518),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 50,
                    width: Get.width,
                    child: TextButton(
                      onPressed: () {
                        (controller.activeIndex == 0) ?
                        controller.updateActiveIndex(1)
                        :
                        (controller.activeIndex == 1) ?
                        controller.updateActiveIndex(2)
                        :
                        Get.toNamed(signUpScreen);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff041C40),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      child: (controller.activeIndex == 2)?
                      const Text(
                        "Get Started",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "CircularStdMedium"
                        ),
                      )
                      :
                      const Text(
                        "Next",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "CircularStdMedium"
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff5E5E5E),
                          fontSize: 16,
                          fontFamily: "CabinetMedium"
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(loginScreen);
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xffD3A518),
                            fontSize: 16,
                            fontFamily: "CabinetBold"
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}