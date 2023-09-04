import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class InterviewView extends StatelessWidget {
  const InterviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            const Text(
              "View your pending and scheduled interviews here",
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
                    subtitle: Row(
                      children: [
                        const Text(
                          "15th Mar, 2023",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff5E5E5E),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                            color: const Color(0xffD3A518),
                            borderRadius: BorderRadius.circular(5)
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "10:00 AM",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff5E5E5E),
                          ),
                        ),
                      ],
                    ),
                    trailing: const Text(
                      "View Details",
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