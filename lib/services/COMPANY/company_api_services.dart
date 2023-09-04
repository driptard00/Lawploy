import 'package:dio/dio.dart';

import '../../routes/api_routes.dart';
import '../../storage/secureStorage.dart';

class CompanyApiServices {
    //  COMPANY ONBOARDING ROUTE
  static Future<Response?> companyOnboardingService(Map<String, dynamic> companyOnboardingDetails) async{
    try {
      String fullUrl = "$baseUrl$companyOnboardingRoute";
      print("FULLURL:$fullUrl");

      String token = await LocalStorage().fetchUserToken();

      var response = await Dio().post(
        fullUrl,
        data: companyOnboardingDetails,
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
  static Future<Response?> getCompanyProfileService() async{
    try {
      String fullUrl = "$baseUrl$getCompanyProfileRoute";
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

  //  UPDATE COMPANY PROFILE ROUTE
  static Future<Response?> updateCompanyProfile(Map<String, dynamic> updateCompanyProfileDetails) async{
    try {
      String fullUrl = "$baseUrl$updateCompanyProfileRoute";
      print("FULLURL:$fullUrl");

      String token = await LocalStorage().fetchUserToken();

      var response = await Dio().put(
        fullUrl,
        data: updateCompanyProfileDetails,
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

  //  UPDATE COMPANY PROFILE ROUTE
  static Future<Response?> updateCompanyProfileImage(Map<String, dynamic> details) async{
    try {
      String fullUrl = "$baseUrl$updateCompanyProfileImageRoute";
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

  //  UPDATE COMPANY PASSWORD ROUTE
  static Future<Response?> updateCompanyPasswordService(Map<String, dynamic> updateCompanyPasswordDetails) async{
    try {
      String fullUrl = "$baseUrl$updateCompanyPasswordRoute";
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

  //  UPDATE COMPANY IN APP NOTIFICATION ROUTE
  static Future<Response?> updateCompanyInAppNotificatonService() async{
    try {
      String fullUrl = "$baseUrl$companyUpdateInAppNotificationRoute";
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

  //  UPDATE COMPANY EMAIL NOTIFICATION ROUTE
  static Future<Response?> updateCompanyEmailNotificatonService() async{
    try {
      String fullUrl = "$baseUrl$companyUpdateEmailNotificationRoute";
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

  //  UPDATE COMPANY VISIBILITY ROUTE
  static Future<Response?> updateCompanyVisibilityService() async{
    try {
      String fullUrl = "$baseUrl$companyUpdateVisibilityRoute";
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

  //  COMPANY GET ALL LAWYERS
  static Future<Response?> companyGetAllLawyersService() async{
    try {
      String fullUrl = "$baseUrl$companyGetAllLawyersRoute";
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

  //  COMPANY GET SINGLE LAWYERS
  static Future<Response?> companyGetSingleLawyer(String id) async{
    try {
      String fullUrl = "$baseUrl$companySinlgeLawyerRoute$id";
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