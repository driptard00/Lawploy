import 'package:dio/dio.dart';
import 'package:lawploy_app/routes/api_routes.dart';

import '../../storage/secureStorage.dart';

class BriefsApiServices {
  
  // GET BRIEFS SERVICE
  static Future<Response?> getMyBriefsService() async{
    try {
      String fullUrl = "$baseUrl$getMyBriefsRoute";
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

  // GET SINGLE BRIEF SERVICE
  static Future<Response?> getSingleBriefService() async{
    try {
      String fullUrl = "$baseUrl$getSingleBriefRoute";
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

  // DELETE BRIEF SERVICE
  static Future<Response?> deleteBriefService(String userId) async{
    try {
      String fullUrl = "$baseUrl$deleteBriefRoute$userId";
      print("FULLURL:$fullUrl");

      String token = await LocalStorage().fetchUserToken();

      var response = await Dio().delete(
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

  // CREATE BRIEF SERVICE
  static Future<Response?> createBriefService(Map<String, dynamic> details) async{
    try {
      String fullUrl = "$baseUrl$createBriefRoute";
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

  // GET SHARED BRIEF SERVICE
  static Future<Response?> getSharedBriefService() async{
    try {
      String fullUrl = "$baseUrl$getSharedBriefRoute";
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