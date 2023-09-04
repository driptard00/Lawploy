import 'package:flutter/material.dart';

class OutflowView extends StatelessWidget {
  const OutflowView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index){
          return ListTile(
            leading: Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xffFF0000).withOpacity(0.2)
              ),
            ),
            title: const Text(
              "Transfer From Michael James",
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
                Center(
                  child: Container(
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                        color: const Color(0xffD3A518),
                        borderRadius: BorderRadius.circular(5)
                    ),
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
            trailing: const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "NGN100,000.00",
                  style: TextStyle(
                      color: Color(0xff0E0E0E),
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Successful",
                  style: TextStyle(
                    color: Color(0xff3AC56C),
                    fontSize: 12,
                  ),
                )
              ],
            )
          );
        },
        separatorBuilder: (context, index){
          return const Divider(
            color: Color(0xffCFCFCF),
          );
        },
        itemCount: 5
    );
  }
}
