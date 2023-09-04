import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lawploy_app/controllers/lawyerStateController.dart';

class GetLawyerProfileService extends StatefulWidget {
  const GetLawyerProfileService({super.key});

  @override
  State<GetLawyerProfileService> createState() => _GetLawyerProfileServiceState();
}
  final LawyerStateController _lawyerStateController = Get.put(LawyerStateController());

  getLawyerDetails() {
  }

class _GetLawyerProfileServiceState extends State<GetLawyerProfileService> {

  @override
  void initState() {
    _lawyerStateController.getLawyerDetails();
    // TODO: implement initState
    super.initState();
  }

  @override   
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white,
        child: const Center(
          child: SpinKitThreeBounce(
            color: Color(0xff041C40),
          ),
        ),
      ),
    );
  }
}