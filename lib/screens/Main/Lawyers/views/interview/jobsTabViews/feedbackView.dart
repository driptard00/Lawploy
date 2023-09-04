import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/routes/app_route_names.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            const Text(
              "View your feedbacks and reference letter from companies",
              style: TextStyle(
                color: Color(0xff5E5E5E),
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: ListTile(
                        onTap: (){},
                        leading: Container(
                          height: 37,
                          width: 37,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(37)
                          ),
                        ),
                        title: const Text(
                          "Quantum Incorporation",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff0E0E0E),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        trailing: InkWell(
                          onTap: () {
                            Get.toNamed(interviewFeedbackScreen);
                          },
                          child: const Text(
                            "View Feedback",
                            style: TextStyle(
                              color: Color(0xffD3A518),
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}