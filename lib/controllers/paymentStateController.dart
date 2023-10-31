import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lawploy_app/services/PAYMENT/payment_api_service.dart';
import 'package:lawploy_app/services/flutter_wave/flutter_wave_service.dart';

class PaymentStateController extends GetxController {

  // INSTANT VARIABLES
  List<dynamic> _outflowList = [];
  List<dynamic> _inflowList = [];
  bool _isLoading = false;

  // GETTERS
  List get outflowList => _outflowList;
  List get inflowList => _inflowList;
  bool get isLoading => _isLoading;

  // SETTERS
  updateOutflowList(value){
    _outflowList = value;
    update();
  }
  updateInflowList(value){
    _inflowList = value;
    update();
  }
  updateIsLoading(value){
    _isLoading = value;
    update();
  }
  dynamic updateCommissinFee(int value){
    double fee = (value * 10)/100;
    return fee;
  }
  dynamic totalFee(int value, fee){
    num total = value + fee;
    return total;
  }

  // GET PAYMENT DETAILS
  Future<void> getAllPayments() async{
    updateIsLoading(true);

    var response = await PAYMENTAPISERVICE.getAllPaymentServcie();
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      updateOutflowList(responseData["data"]["outgoing"]);
      updateInflowList(responseData["data"]["incoming"]);

    } else {
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: responseData["error"],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
    update();
  }

    Future<void> paymentInit(BuildContext context, String name, phone, email, dynamic amount, auth, auth2) async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "senderId": auth,
      "recevierId": auth2,
      "reason": "For payment",
      "type": "breif",
      "currency": "NGN",
      "amount": amount
    };

    print(details);

    var response = await PAYMENTAPISERVICE.initPaymentService(details);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      FlutterWaveService().handlePaymentInitialization(
        context,
        name,
        phone,
        email,
        amount.toString(),
        responseData["data"]["_id"]
      );

    } else {
      updateIsLoading(false);
      Fluttertoast.showToast(
        msg: responseData["error"],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }

    update();
  }

}