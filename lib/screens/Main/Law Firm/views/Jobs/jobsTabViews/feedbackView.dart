import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Color(0xffCFCFCF),
                  );
                },
                itemBuilder: (context, index) {
                  return ListTile(
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
                    trailing: const Text(
                      "View Feedback",
                      style: TextStyle(
                        color: Color(0xffD3A518),
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    )
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