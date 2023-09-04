import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dojah_kyc/flutter_dojah_kyc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lawploy_app/routes/app_route_names.dart';

class LawyerKycVerification {
  static Future<void> kycVerification(BuildContext context, String userAuth) async{
    print(userAuth);
    var appId = dotenv.env["DOJAH_APP_ID"]; //your application ID
    var publicKey = dotenv.env["DOJAH_PUBLIC_KEY"];
    
    final userData = {
      "first_name": "",
      "last_name": "",
      "dob": "",
      "residence_country": "Nigeria"
    };

    final configObj = {
      "debug": "true",
      // "mobile": true,
      // "otp": false,
      // "selfie": true,
      // "aml": false,
      "webhook": true, //Before you set webhook to true, Ensure you are subscribed to the webhook here https://api-docs.dojah.io/docs/subscribe-to-services
      "review_process": "Automatic",
      "pages": [
        // { "page": "phone-number", "config": { "verification": true } },
        { "page": "government-data", "config": { "bvn": true, "nin": false, "dl": false, "mobile": false, "otp": false, "selfie": false } }, 

        // { "page": "user-data", "config": { "enabled": false } },
        // { "page": "countries", "config": { "enabled": false } },
        // { "page": "business-data", "config": {"cac": true, "tin": false, "verification": true} },
        // { "page": "business-id" },
        // { "page": "selfie", "config": { "verification": true }},
        // { "page": "address", "config": { "verification": true }},
        // { "page": 'id', "config": { "passport": true, "dl": true , "nin": true, "voter":true, "custom": true } },
      ]
    };
    
    final metaData = {
      "user_id": userAuth,
    };

    DojahKYC _dojahKCY;
    //Use your appId and publicKey
    _dojahKCY = DojahKYC(
      appId: appId!,
      publicKey: publicKey!,
      type: "custom",
      userData: userData,
      metaData: metaData,
      // govData: govData,
      config: configObj,
    );

    print(json.encode(configObj));
    print(json.encode(configObj));
    // print(userData);
    print(configObj);
    _dojahKCY.open(
      context,
      onSuccess: (result) async{
        print(result);
        Get.offAllNamed(getLawFirmDetailScreen);
      },
      onClose: (close){
        Get.back();
      },
      onError: (error) {
        print(error);
        Get.back();
      }
    );
  }
} 
