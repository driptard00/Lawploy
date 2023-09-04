import 'package:dio/dio.dart';
import 'package:lawploy_app/routes/api_routes.dart';

class PingApiService {
  static Future<Response?> pingServerService() async{
    try {
      String fullUrl = baseUrl;
      print("FULLURL:$fullUrl");

      var response = await Dio().get(
        fullUrl,
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