import 'package:dio/dio.dart';

import '../../routes/api_routes.dart';
import '../../storage/secureStorage.dart';

class LawFirmApiServices {
      //  LAW FIRM ONBOARDING ROUTE
  static Future<Response?> lawFirmOnboardingService(Map<String, dynamic> lawFirmOnboardingDetails) async{
    try {
      String fullUrl = "$baseUrl$lawFirmOnboardingRoute";
      print("FULLURL:$fullUrl");

      String token = await LocalStorage().fetchUserToken();

      var response = await Dio().post(
        fullUrl,
        data: lawFirmOnboardingDetails,
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

  //  GET LAW FIRM PROFILE ROUTE
  static Future<Response?> getLawFirmProfileService() async{
    try {
      String fullUrl = "$baseUrl$getLawFirmProfileRoute";
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

  //  UPDATE LAWYER PASSWORD ROUTE
  static Future<Response?> updateLawFirmPasswordService(Map<String, dynamic> updateLawFirmPasswordDetails) async{
    try {
      String fullUrl = "$baseUrl$updateLawFirmPasswordRoute";
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

  //  UPDATE FIRM IN APP NOTIFICATION ROUTE
  static Future<Response?> updateFirmInAppNotificatonService() async{
    try {
      String fullUrl = "$baseUrl$firmUpdateInAppNotificationRoute";
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

  //  UPDATE FIRM EMAIL NOTIFICATION ROUTE
  static Future<Response?> updateFirmEmailNotificatonService() async{
    try {
      String fullUrl = "$baseUrl$firmUpdateEmailNotificationRoute";
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

  //  UPDATE FIRM VISIBILITY ROUTE
  static Future<Response?> updateFirmVisibilityService() async{
    try {
      String fullUrl = "$baseUrl$firmUpdateVisibilityRoute";
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

  //  UPDATE lawfirm image ROUTE
  static Future<Response?> updateProfileImageService(Map<String, dynamic> details) async{
    try {
      String fullUrl = "$baseUrl$updateLawFirmProfileImageRoute";
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

  // FIRM GET ALL LAWYERS
  static Future<Response?> firmGetAllLawyersService() async{
    try {
      String fullUrl = "$baseUrl$lawFirmGetAllLawyersRoute";
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

  //  law firm GET SINGLE LAWYERS
  static Future<Response?> firmGetSingleLawyer(String id) async{
    try {
      String fullUrl = "$baseUrl$lawFirmSinlgeLawyerRoute$id";
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