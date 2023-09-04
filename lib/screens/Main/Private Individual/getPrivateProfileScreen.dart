import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lawploy_app/controllers/privateStateController.dart';

class GetPrivateProfileScreen extends StatefulWidget {
  const GetPrivateProfileScreen({super.key});

  @override
  State<GetPrivateProfileScreen> createState() => _GetPrivateProfileScreenState();
}
  final PrivateStateController _privateStateController = Get.put(PrivateStateController());

  getLawyerDetails() {
  }

class _GetPrivateProfileScreenState extends State<GetPrivateProfileScreen> {

  @override
  void initState() {
    _privateStateController.getPrivateDetails();
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