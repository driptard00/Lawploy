import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CallsScreenView extends StatelessWidget {
  const CallsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  "images/comingsoon.png",
                  height: 200,
                  width: 200,
                ),
              )
              // ListView.separated(
              //   itemCount: 3,
              //   separatorBuilder: (context, index) {
              //     return const Divider(
              //       color: Color(0xffCFCFCF),
              //     );
              //   },
              //   itemBuilder: (context, index) {
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 10),
              //       child: Row(
              //         children: [
              //           const Expanded(
              //             flex: 1,
              //             child: CircleAvatar(
              //               radius: 20,
              //             ),
              //           ),
              //           const SizedBox(width: 10,),
              //           Expanded(
              //             flex: 9,
              //             child: Row(
              //               children: [
              //                 Expanded(
              //                   flex: 7,
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       const Text(
              //                         "Rachael Palmer(3)",
              //                         style: TextStyle(
              //                           color:Color(0xff0E0E0E),
              //                           fontSize: 14,
              //                           fontWeight: FontWeight.w700
              //                         ),
              //                       ),
              //                       const SizedBox(height: 5,),
              //                       Row(
              //                         children: const [
              //                           Icon(
              //                             Iconsax.call5,
              //                             color: Color(0xff5E5E5E),
              //                             size: 12,
              //                           ),
              //                           Text(
              //                             "Outgoing",
              //                             style: TextStyle(
              //                               color:Color(0xff5E5E5E),
              //                               fontSize: 12
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 const Expanded(
              //                   flex: 3,
              //                   child: Align(
              //                     alignment: Alignment.centerRight,
              //                     child: Text(
              //                       "10:59 AM",
              //                       style: TextStyle(
              //                         color: Color(0xff5E5E5E),
              //                         fontSize: 12
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // ),
            ),
          ],
        ),
      ),
    );
  }
}