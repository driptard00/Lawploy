import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FeedBackScreen extends StatelessWidget {
  FeedBackScreen({super.key});

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
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                const ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                  ),
                  title: Text(
                    "Quantum Incorporation",
                    style:  TextStyle(
                      color: Color(0xff0E0E0E),
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  subtitle: Text(
                    "Part-Time",
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
                    children: const [
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
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi commodo, hendrerit sapien ut enim semper pellue. Pellentesque facilisi ligula mattis arcu. Dictumst adicing sit rhoncus quisque senectus ut mi, nulla purus. Arcu venenatis it proin sit tristique massa. Eu ut ornare adipng vulputate nec lorem arcu. Velit congue fermentumPellentesque facilisi ligula mattis arcu. Dictumst adicing sit rhoncus quisqu Eu ut ornare adipng vulputate nec lorem arcu. ",
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
    );
  }
}