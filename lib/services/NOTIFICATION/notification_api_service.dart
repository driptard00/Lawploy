import 'package:dio/dio.dart';
import 'package:lawploy_app/routes/api_routes.dart';
import 'package:lawploy_app/storage/secureStorage.dart';

class NotificationApiService {
  static Future<Response?> getAllNotificationService() async{
    try {
      String fullUrl = "$baseUrl$getNotifcationRoute";
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

  static Future<Response?> markAllNotifcationService() async{
    try {
      String fullUrl = "$baseUrl$markAllNotificationRead";
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