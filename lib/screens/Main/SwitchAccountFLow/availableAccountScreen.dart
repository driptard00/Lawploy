import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/authStateController.dart';
import 'package:lawploy_app/routes/app_route_names.dart';

class AllAvailableAccountsScreen extends StatelessWidget {
  AllAvailableAccountsScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthStateController _authStateController = Get.put(AuthStateController());

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _authStateController.getAllAccounts();
    },);

    return GetBuilder<AuthStateController>(
      builder: (controller) {
        return Scaffold(
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
              "Select Account",
              style: TextStyle(
                color: Color(0xff03132B),
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            centerTitle: true,
          ),
          body: (controller.isLoading)?
          const Center(
            child: SpinKitThreeBounce(
              color: Color(0xff041C40),
            ),
          )
          :
          Container(
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
                          children: [
                            const SizedBox(height: 20,),
                            const Text(
                              "Select an account you want to switch to",
                              style: TextStyle(
                                color: Color(0xff5E5E5E),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      (controller.allAccounts["lawyer"] == null)?
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(personalDetailsLawyer);
                                        },
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.black
                                            )
                                          ),
                                          child: const Icon(
                                            Iconsax.add
                                          )
                                        ),
                                      )
                                      :
                                      InkWell(
                                        onTap: () {
                                          controller.updateSelectedAccount("lawyer");
                                        },
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: (controller.selectedAccount == "lawyer")?
                                            Border.all(
                                              color: const Color(0xff041C40),
                                              width: 2
                                            )
                                            :
                                            null,
                                            image: DecorationImage(
                                              image: (controller.allAccounts["lawyer"]["profile_image"] == null)?
                                              const AssetImage(
                                                "images/profileAvatar.png"
                                              ) as ImageProvider
                                              :
                                              NetworkImage(
                                                controller.allAccounts["lawyer"]["profile_image"]
                                              ),
                                              fit: BoxFit.cover
                                            )
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      (controller.allAccounts["lawyer"] == null)?
                                      const Text(
                                        "Create Lawyer Account"
                                      )
                                      :
                                      Text(
                                        controller.allAccounts["lawyer"]["first_name"]
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      (controller.allAccounts["firm"] == null)?
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(createNewAccountTypeFirm);
                                        },
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.black
                                            )
                                          ),
                                          child: const Icon(
                                            Iconsax.add
                                          )
                                        ),
                                      )
                                      :
                                      InkWell(
                                        onTap: () {
                                          controller.updateSelectedAccount("firm");
                                        },
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: (controller.selectedAccount == "firm")?
                                            Border.all(
                                              color: const Color(0xff041C40),
                                              width: 2
                                            )
                                            :
                                            null,
                                            image: DecorationImage(
                                              image: (controller.allAccounts["firm"]["profile_image"] == null)?
                                              const AssetImage(
                                                "images/profileAvatar.png"
                                              ) as ImageProvider
                                              :
                                              NetworkImage(
                                                controller.allAccounts["firm"]["profile_image"]
                                              ),
                                              fit: BoxFit.cover
                                            )
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      (controller.allAccounts["firm"] == null)?
                                      const Text(
                                        "Create Firm Account"
                                      )
                                      :
                                      Text(
                                        controller.allAccounts["firm"]["name"]
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30,),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      (controller.allAccounts["corporation"] == null)?
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(createNewAccountTypeCompany);
                                        },
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.black
                                            )
                                          ),
                                          child: const Icon(
                                            Iconsax.add
                                          )
                                        ),
                                      )
                                      :
                                      InkWell(
                                        onTap: () {
                                          controller.updateSelectedAccount("corporation");
                                        },
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: (controller.selectedAccount == "corporation")?
                                            Border.all(
                                              color: const Color(0xff041C40),
                                              width: 2
                                            )
                                            :
                                            null,
                                            image: DecorationImage(
                                              image: (controller.allAccounts["corporation"]["profile_image"] == null)?
                                              const AssetImage(
                                                "images/profileAvatar.png"
                                              ) as ImageProvider
                                              :
                                              NetworkImage(
                                                controller.allAccounts["corporation"]["profile_image"]
                                              ),
                                              fit: BoxFit.cover
                                            )
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      (controller.allAccounts["corporation"] == null)?
                                      const Text(
                                        "Create Company Account"
                                      )
                                      :
                                      Text(
                                        controller.allAccounts["corporation"]["name"]
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      (controller.allAccounts["private"] == null)?
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(createNewAccountTypePrivate);
                                        },
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            
                                            border: Border.all(
                                              color: Colors.black
                                            )
                                          ),
                                          child: const Icon(
                                            Iconsax.add
                                          )
                                        ),
                                      )
                                      :
                                      InkWell(
                                        onTap: () {
                                          controller.updateSelectedAccount("private");
                                        },
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: (controller.selectedAccount == "private")?
                                            Border.all(
                                              color: const Color(0xff041C40),
                                              width: 2
                                            )
                                            :
                                            null,
                                            image: DecorationImage(
                                              image: (controller.allAccounts["private"]["profile_image"] == null)?
                                              const AssetImage(
                                                "images/profileAvatar.png"
                                              ) as ImageProvider
                                              :
                                              NetworkImage(
                                                controller.allAccounts["private"]["profile_image"]
                                              ),
                                              fit: BoxFit.cover
                                            )
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      (controller.allAccounts["private"] == null)?
                                      const Text(
                                        "Create Private Individual Account",
                                        textAlign: TextAlign.center,
                                      )
                                      :
                                      Text(
                                        controller.allAccounts["private"]["first_name"]
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: SizedBox(
                          height: 50,
                          width: Get.width,
                          child: TextButton(
                            onPressed: () {
                              controller.switchAccount(controller.selectedAccount);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xff041C40),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                            ),
                            child: const Text(
                              "Switch",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                              ),
                            ),
                          ),
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