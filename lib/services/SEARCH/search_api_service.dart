import 'package:dio/dio.dart';

import '../../routes/api_routes.dart';
import '../../storage/secureStorage.dart';

class SearchApiService {
  
  //  SEARCH FOR LAWYERS SERVICE
  static Future<Response?> searchForLawyerService(String country, year, specialization, state, lga, sortby, keyword) async{
    try {
      String fullUrl = "$baseUrl$searchForLawyerRoute";
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
        ),
        queryParameters: {
          "country": country,
          "year": year,
          "specialization": specialization,
          "state": state,
          "lga": lga,
          "keyword": keyword,
          "sortby": sortby,
          
        }
      );
      return response;

    } on DioError catch (error) {
      if(error.response != null){
        return error.response;
      }
      throw Exception(error.response);
    }
  }
  
  //  SEARCH FOR LAWYERS SERVICE
  static Future<Response?> searchForCompanyService(String? country, year, specialization, state, lga, keyword, sortby) async{
    try {
      String fullUrl = "$baseUrl$searchForCompanyRoute";
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
        ),
        queryParameters: {
          "country": country,
          "year": year,
          "specialization": specialization,
          "state": state,
          "lga": lga,
          "keyword": keyword,
          "sortby": sortby,
        }
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