import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../services/NOTIFICATION/notification_api_service.dart';

class NotificationStateController extends GetxController {

  // INSTANT VARIABLES
  List<dynamic> _notificationList = [];
  List<dynamic> _unseenNotifications = [];
  bool _isLoading = false;


  // GETTERS
  List get notificationList => _notificationList;
  List get unseenNotifications => _unseenNotifications;
  bool get isLoading => _isLoading;

  // SETTERS
  updateNotifcationList(value) {
    _notificationList = value;
    update();
  }
  updateIsLoading(value) {
    _isLoading = value;
    update();
  }

  // GET ALL NOTIFICATIONS
  Future<void> getAllNotifications() async{
    updateIsLoading(true);

    var response = await NotificationApiService.getAllNotificationService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
      
      updateNotifcationList(responseData["data"]);
      getUnseenNotifications();

    } else {
      updateIsLoading(false);
      Fluttertoast.showToast(
        msg: responseData["error"],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    }
  }

  // MARK ALL NOTIFICATION SERVICE
  Future<void> markAllNotification() async{
    updateIsLoading(true);

    var response = await NotificationApiService.markAllNotifcationService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
      
      getAllNotifications();
      
    } else {
      updateIsLoading(false);
      Fluttertoast.showToast(
        msg: responseData["error"],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    }
  }

  Future<void> getUnseenNotifications() async{ 
    _unseenNotifications = _notificationList.where((unseen) => unseen["seen"] == false).toList();
    print("UNSEENNNN::::: $_unseenNotifications");
    update();
  }

}