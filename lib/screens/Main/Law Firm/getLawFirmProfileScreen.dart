import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lawploy_app/controllers/lawfirmStateController.dart';


class GetLawFirmProfileScreen extends StatefulWidget {
  const GetLawFirmProfileScreen({super.key});

  @override
  State<GetLawFirmProfileScreen> createState() => _GetLawFirmProfileScreenState();
}
  final LawFirmStateController _lawFirmStateController = Get.put(LawFirmStateController());

class _GetLawFirmProfileScreenState extends State<GetLawFirmProfileScreen> {

  @override
  void initState() {
   _lawFirmStateController.getLawFirmProfile();
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