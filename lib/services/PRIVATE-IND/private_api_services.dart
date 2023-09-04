import 'package:dio/dio.dart';

import '../../routes/api_routes.dart';
import '../../storage/secureStorage.dart';

class PrivateApiServices {
    //  PRIVATE ONBOARDING ROUTE
  static Future<Response?> privateOnboardingService(Map<String, dynamic> privateOnboardingDetails) async{
    try {
      String fullUrl = "$baseUrl$piOnboardingRoute";
      print("FULLURL:$fullUrl");

      String token = await LocalStorage().fetchUserToken();

      var response = await Dio().post(
        fullUrl,
        data: privateOnboardingDetails,
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

  //  GET COMPANY PROFILE ROUTE
  static Future<Response?> getPrivateProfileService() async{
    try {
      String fullUrl = "$baseUrl$getPIProfileRoute";
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

  //  UPDATE PRIVATE PROFILE ROUTE
  static Future<Response?> updatePrivateProfileService(Map<String, dynamic> updatePrivateProfileDetails) async{
    try {
      String fullUrl = "$baseUrl$updatePrivateProfileRoute";
      print("FULLURL:$fullUrl");

      String token = await LocalStorage().fetchUserToken();

      var response = await Dio().put(
        fullUrl,
        data: updatePrivateProfileDetails,
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

  //  UPDATE PRIVATE PROFILE IMAGE ROUTE
  static Future<Response?> updatePrivateProfileImageService(Map<String, dynamic> updatePrivateProfilImageeDetails) async{
    try {
      String fullUrl = "$baseUrl$updatePrivateProfileImageRoute";
      print("FULLURL:$fullUrl");

      String token = await LocalStorage().fetchUserToken();

      var response = await Dio().put(
        fullUrl,
        data: updatePrivateProfilImageeDetails,
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

  //  UPDATE PRIVATE PASSWORD ROUTE
  static Future<Response?> updatePrivatePasswordService(Map<String, dynamic> updatePrivatePasswordDetails) async{
    try {
      String fullUrl = "$baseUrl$updatePrivatePasswordRoute";
      print("FULLURL:$fullUrl");

      String token = await LocalStorage().fetchUserToken();

      var response = await Dio().put(
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

  //  UPDATE PRIVATE IN APP NOTIFICATION ROUTE
  static Future<Response?> updatePrivateInAppNotificatonService() async{
    try {
      String fullUrl = "$baseUrl$privateUpdateInAppNotificationRoute";
      print("FULLURL:$fullUrl");

      String token = await LocalStorage().fetchUserToken();

      var response = await Dio().put(
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

  //  UPDATE PRIVATE EMAIL NOTIFICATION ROUTE
  static Future<Response?> updatePrivateEmailNotificatonService() async{
    try {
      String fullUrl = "$baseUrl$privateUpdateEmailNotificationRoute";
      print("FULLURL:$fullUrl");

      String token = await LocalStorage().fetchUserToken();

      var response = await Dio().put(
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

  //  UPDATE PRIVATE VISIBILITY ROUTE
  static Future<Response?> updatePrivateVisibilityService() async{
    try {
      String fullUrl = "$baseUrl$privateUpdateVisibilityRoute";
      print("FULLURL:$fullUrl");

      String token = await LocalStorage().fetchUserToken();

      var response = await Dio().put(
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


  //  PRIVATE GET ALL LAWYERS
  static Future<Response?> privateGetAllLawyersService() async{
    try {
      String fullUrl = "$baseUrl$privateGetAllLawyersRoute";
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

  //  private GET SINGLE LAWYERS
  static Future<Response?> privateGetSingleLawyer(String id) async{
    try {
      String fullUrl = "$baseUrl$privateSinlgeLawyerRoute$id";
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