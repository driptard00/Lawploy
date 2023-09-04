import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawploy_app/controllers/appStateController.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
  final AppStateController _appStateController = Get.put(AppStateController());

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _appStateController.pingServer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: const Color(0xff041C40),
        child: Center(
          child: Image.asset(
            "images/logo.png",
          ),
        ),
      ),
    );
  }
}