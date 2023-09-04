import 'package:dio/dio.dart';
import 'package:lawploy_app/routes/api_routes.dart';
import 'package:lawploy_app/storage/secureStorage.dart';

class SwitchAccountService {
  static Future<Response?> getAllAccountsService() async{
    try {
      String fullUrl = "$baseUrl$getAllAccountsRoute";
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

  static Future<Response?> createNewAccountTypeServcie(Map<String, dynamic> details) async{
    try {
      String fullUrl = "$baseUrl$createNewAccountTypeRoute";
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

  static Future<Response?> switchAccountService(Map<String, dynamic> details) async{
    try {
      String fullUrl = "$baseUrl$switchAccountRoute";
      print("FULLURL:$fullUrl");

      String token = await LocalStorage().fetchUserToken();

      var response = await Dio().put(
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
}