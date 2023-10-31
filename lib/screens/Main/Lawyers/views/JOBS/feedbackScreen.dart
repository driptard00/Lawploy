import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FeedBackScreen extends StatelessWidget {
  FeedBackScreen({super.key});

  final feedback = Get.arguments["feedback"];
  final name = Get.arguments["name"];
  final positionType = Get.arguments["positionType"];
  final image = Get.arguments["image"];

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
          "Feedback",
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: (image == null)?
                      AssetImage(
                        "images/profileAvatar.png"
                      ) as ImageProvider
                      :
                      NetworkImage(
                        image
                      ),
                    ),
                    title: Text(
                      name,
                      style:  TextStyle(
                        color: Color(0xff0E0E0E),
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    subtitle: Text(
                      positionType,
                      style:  TextStyle(
                        color: Color(0xff5E5E5E),
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: Color(0xffD3D3D3),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          "Feedback",
                          style: TextStyle(
                            color: Color(0xff0E0E0E),
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          feedback,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Color(0xff5E5E5E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                          ),
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
    );
  }
}