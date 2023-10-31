import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lawploy_app/controllers/paymentStateController.dart';

class OutflowView extends StatelessWidget {
  OutflowView({super.key});

  var format = NumberFormat('#,##0');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentStateController>(
      builder: (controller) {
        return (controller.isLoading)?
        const Center(
          child: CircularProgressIndicator(
            color: Color(0xff041C40),
          )
        )
        :
        ListView.separated(
            itemBuilder: (context, index){
              String timestamp = controller.outflowList[index]["createdAt"];
              var dateTime = DateTime.parse(timestamp).toLocal();
              var now = DateTime.now();
              bool isToday = dateTime.year == now.year &&
              dateTime.month == now.month &&
              dateTime.day == now.day;

              // Format date and time
              String formattedDate;
              if (isToday) {
                formattedDate = 'Today';
              } else {
                formattedDate = DateFormat('d MMM, y').format(dateTime);
              }

              final formattedTime = DateFormat('h:mma').format(dateTime).toLowerCase();
              return ListTile(
                leading: Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xffFF0000).withOpacity(0.2)
                  ),
                  child: const Center(
                    child: Icon(
                      Iconsax.send4,
                      color: Color(0xffFF0000),
                    ),
                  ),
                ),
                title:  Text(
                  "Transfer To ${controller.outflowList[index]["_recevier"]["lawyerID"]["first_name"]} ${controller.outflowList[index]["_recevier"]["lawyerID"]["last_name"]}",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff0E0E0E),
                      fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      formattedDate,
                      style: const TextStyle(
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
                    Text(
                     formattedTime,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff5E5E5E),
                      ),
                    ),
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "NGN${format.format(controller.outflowList[index]["amount"])}",
                      style: const TextStyle(
                          color: Color(0xff0E0E0E),
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    (controller.outflowList[index]["status"] == "successful")?
                    const Text(
                      "Successful",
                      style: TextStyle(
                        color: Color(0xff3AC56C),
                        fontSize: 12,
                      ),
                    )
                    :
                    (controller.outflowList[index]["status"] == "failed")?
                    const Text(
                      "Failed",
                      style: TextStyle(
                        color: Color(0xffFF0000),
                        fontSize: 12,
                      ),
                    )
                    :
                    const Text(
                      "Pending",
                      style: TextStyle(
                        color: Color(0xffE89D2B),
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
            itemCount: controller.outflowList.length
        );
      }
    );
  }
}
