import 'package:dio/dio.dart';

import '../../routes/api_routes.dart';
import '../../storage/secureStorage.dart';

class InterviewFlowService {

  // SEND INTERVIEW INVITE
  static Future<Response?> sendInterviewInviteService(Map<String, dynamic> details) async{
    try {
      String fullUrl = "$baseUrl$sendInterviewInvite";
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

  // ALL SENT INTERVIEW SERVICE
  static Future<Response?> getAllSentInterviewService() async{
    try {
      String fullUrl = "$baseUrl$getAllSentInterview";
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

  // SINGLE SENT INTERVIEW SERVICE
  static Future<Response?> getSingleSentInterviewService(String id) async{
    try {
      String fullUrl = "$baseUrl$getSingleSentInterview";
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

  // SEND FEEDBACK OR REFERENCE LETTER SERVICE
  static Future<Response?> sendFeedbackService(Map<String, dynamic> details, String id) async{
    try {
      String fullUrl = "$baseUrl$sendFeedback$id";
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

  // ALL RECIEVED INTERVIEWS
  static Future<Response?> getAllRecievedInterviewsService() async{
    try {
      String fullUrl = "$baseUrl$getAllRecievedInterviews";
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

  // SINGLE RECIEVED INTERVIEW SERVICE
  static Future<Response?> getSingleRecievedInterviewService(String id) async{
    try {
      String fullUrl = "$baseUrl$getSingleRecievedInterviews";
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

  // ACCEPT OR REJECT RECIEVED INTERVIEW
  static Future<Response?> acceptOrRejectRecievedInterviewService(Map<String, dynamic> details, String id) async{
    try {
      String fullUrl = "$baseUrl$acceptInterviewInvite$id";
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