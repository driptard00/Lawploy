import 'package:dio/dio.dart';
import '../../routes/api_routes.dart';
import '../../storage/secureStorage.dart';

class PAYMENTAPISERVICE {

  // INIT PAYMENT
  static Future<Response?> initPaymentService(Map<String, dynamic> details) async{
    try {
      String fullUrl = "$baseUrl$paymentInitRoute";
      print("FULLURL:$fullUrl");

      String token = await LocalStorage().fetchUserToken();

      var response = await Dio().post(
        fullUrl,
        data: details,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }
        )
      );
      return response;

    } on DioError catch (error) {
      if(error.response != null){
        return error.response;
      }
      throw Exception(error.response);
    }
  }

  // GET ALL PAYMENT
  static Future<Response?> getAllPaymentServcie() async{
    try {
      String fullUrl = "$baseUrl$getAllPaymentRoute";
      print("FULLURL:$fullUrl");

      String token = await LocalStorage().fetchUserToken();

      var response = await Dio().get(
        fullUrl,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }
        )
      );
      return response;

    } on DioError catch (error) {
      if(error.response != null){
        return error.response;
      }
      throw Exception(error.response);
    }
  }
}