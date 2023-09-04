import 'package:dio/dio.dart';
import 'package:lawploy_app/storage/secureStorage.dart';
import '../../routes/api_routes.dart';

class LawyerApiServices {

  //  LAWYER ONBOARDING ROUTE
  static Future<Response?> lawyerOnboardingService(Map<String, dynamic> lawyerOnboardingDetails) async{
    try {
      String fullUrl = "$baseUrl$lawyerOnboardingRoute";
      print("FULLURL:$fullUrl");

      String token = await LocalStorage().fetchUserToken();

      var response = await Dio().post(
        fullUrl,
        data: lawyerOnboardingDetails,
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

  //  GET LAWYER PROFILE ROUTE
  static Future<Response?> getLawyerProfileService() async{
    try {
      String fullUrl = "$baseUrl$getLawyerProfileRoute";
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

  //  UPDATE LAWYER PROFILE ROUTE
  static Future<Response?> updateLawyerProfileService(Map<String, dynamic> updateLawyerProfileDetails) async{
    try {
      String fullUrl = "$baseUrl$updateLawyerProfileRoute";
      print("FULLURL:$fullUrl");

      String token = await LocalStorage().fetchUserToken();

      var response = await Dio().put(
        fullUrl,
        data: updateLawyerProfileDetails,
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

  //  UPDATE LAWYER IN APP NOTIFICATION ROUTE
  static Future<Response?> updateLawyerInAppNotificatonService() async{
    try {
      String fullUrl = "$baseUrl$lawyerUpdateInAppNotificationRoute";
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

  //  UPDATE LAWYER EMAIL NOTIFICATION ROUTE
  static Future<Response?> updateLawyerEmailNotificatonService() async{
    try {
      String fullUrl = "$baseUrl$lawyerUpdateEmailNotificationRoute";
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

  //  UPDATE LAWYER VISIBILITY ROUTE
  static Future<Response?> updateLawyerVisibilityService() async{
    try {
      String fullUrl = "$baseUrl$lawyerUpdateVisibilityRoute";
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


  //  UPDATE LAWYER PROFILE IMAGE ROUTE
  static Future<Response?> updateLawyerProfileImageService(Map<String, dynamic> updateLawyerProfileImageDetails) async{
    try {
      String fullUrl = "$baseUrl$updateLawyerProfileImageRoute";
      print("FULLURL:$fullUrl");

      String token = await LocalStorage().fetchUserToken();

      var response = await Dio().put(
        fullUrl,
        data: updateLawyerProfileImageDetails,
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
  static Future<Response?> updateLawyerPasswordService(Map<String, dynamic> updateLawyerPasswordDetails) async{
    try {
      String fullUrl = "$baseUrl$updateLawyerPasswordRoute";
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

  //  APPLY FOR A JOB SERVICE
  static Future<Response?> applyForAJobService(Map<String, dynamic> details, String userId) async{
    try {
      String fullUrl = "$baseUrl$applyForJobsRoute$userId";
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

  //  GET MY APPLICATIONS SERVICE
  static Future<Response?> getMyApplicationService() async{
    try {
      String fullUrl = "$baseUrl$getMyApplicationsRoute";
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

  //  GET one application SERVICE
  static Future<Response?> getOneApplicationService(String id) async{
    try {
      String fullUrl = "$baseUrl$getAnpplicationsRoute$id";
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

  //  GET ALL LAWYERS SERVICE
  static Future<Response?> getAllLawyersService() async{
    try {
      String fullUrl = "$baseUrl$getAllLawyersRoute";
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

  //  GET SINGLE LAWYER
  static Future<Response?> getSingleLawyerService(String id) async{
    try {
      String fullUrl = "$baseUrl$getSingleLawyer$id";
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