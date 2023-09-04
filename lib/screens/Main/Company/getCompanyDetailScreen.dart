import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../controllers/companyStateController.dart';

class GetCompanyProfileScreen extends StatefulWidget {
  const GetCompanyProfileScreen({super.key});

  @override
  State<GetCompanyProfileScreen> createState() => _GetCompanyProfileScreenState();
}
  final CompanyStateController _companyStateController = Get.put(CompanyStateController());

class _GetCompanyProfileScreenState extends State<GetCompanyProfileScreen> {

  @override
  void initState() {
    _companyStateController.getCompanyProfile();
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