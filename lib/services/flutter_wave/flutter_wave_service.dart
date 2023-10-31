import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:lawploy_app/routes/app_route_names.dart';

class FlutterWaveService {
  handlePaymentInitialization(BuildContext context, String name, phoneNumber, email, dynamic amount, String id) async {

    final Customer customer = Customer(
        name: name,
        phoneNumber: phoneNumber,
        email: email
    );
    final Future<ChargeResponse> flutterwave = Flutterwave(
        context: context,
        publicKey: dotenv.env["FLUTTER_WAVE_PUBLIC_KEY"]!,
        currency: "NGN",
        redirectUrl: splashScreen,
        txRef: id,
        amount: amount,
        customer: customer,
        paymentOptions: "card",
        customization: Customization(title: "My Payment"),
        isTestMode: true 
    ).charge();
  }

}