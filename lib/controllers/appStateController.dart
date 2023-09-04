import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawploy_app/screens/Main/Lawyers/views/Briefs/briefsScreen.dart';
import 'package:lawploy_app/screens/Main/Messages/messageScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp/whatsapp.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import '../routes/app_route_names.dart';
import '../screens/Main/Company/views/Briefs/briefsScreen.dart';
import '../screens/Main/Company/views/Home/homeScreen.dart';
import '../screens/Main/Company/views/Jobs/jobsScreen.dart';
import '../screens/Main/Company/views/Profile/profileScreen.dart';
import '../screens/Main/Law Firm/views/Briefs/briefsScreen.dart';
import '../screens/Main/Law Firm/views/Home/homeScreen.dart';
import '../screens/Main/Law Firm/views/Jobs/jobsScreen.dart';
import '../screens/Main/Law Firm/views/Profile/profileScreen.dart';
import '../screens/Main/Lawyers/views/Home/homeScreen.dart';
import '../screens/Main/Lawyers/views/JOBS/jobsScreen.dart';
import '../screens/Main/Lawyers/views/Profile/profileScreen.dart';
import '../screens/Main/Private Individual/views/Briefs/briefsScreen.dart';
import '../screens/Main/Private Individual/views/Home/homeScreen.dart';
import '../screens/Main/Private Individual/views/Jobs/jobsScreen.dart';
import '../screens/Main/Private Individual/views/Profile/profileScreen.dart';
import '../services/NOTIFICATION/notification_api_service.dart';
import '../services/ping_service.dart';
import '../storage/secureStorage.dart';

class AppStateController extends GetxController {
  // INSTANT VARIABLES
  int _activeIndex = 0;
  int _selectedLawyerScreenIndex = 0;
  int _selectedLawFirmScreenIndex = 0;
  int _selectedCompanyScreenIndex = 0;
  int _selectedPIScreenIndex = 0;
  bool _isLoading = false;
  List<dynamic> _notificationList = [];
  final List<Map<String, dynamic>> _onboardingItems = [
    {
      "image": "images/lawyer.png",
      "title": "Hold Briefs in your Jurisdiction",
      "subText": "Lawyers are looking for colleagues to hold their briefs. Set your profile, your appearance feels and starting holding briefs."
    },
    {
      "image": "images/interview.png",
      "title": "Lawyers Recruitment platform",
      "subText": "Lawploy brings Lawyers, Law firms and Companies recruiting Lawyers in one platform for fast and easy recruitment process"
    },
    {
      "image": "images/lawyer1.png",
      "title": "Private Legal Practitioners",
      "subText": "As a practicing Lawyer, get fully noticed by potential clients, set your profile and start working from home today."
    },
  ];
  final List<Widget> _lawyerScreens = [
    HomeScreen(),
    BriefScreen(),
    JobScreen(),
    MessageScreen(),
    ProfileScreen()
  ];

  final List<Widget> _lawFirmsScreens = [
    LFHomeScreen(),
    LFBriefScreen(),
    LFJobScreen(),
    MessageScreen(),
    LFProfileScreen()
  ];

  final List<Widget> _companyScreens = [
    CompanyHomeScreen(),
    CompanyJobScreen(),
    MessageScreen(),
    CompanyProfileScreen(),
  ];

  final List<Widget> _piScreens = [
    PIHomeScreen(),
    PIJobScreen(),
    MessageScreen(),
    PIProfileScreen()
  ];
  String _imageUrl = "";
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  FirebaseStorage storage = FirebaseStorage.instance;
  List _unseenNotifications = [];


  // GETTERS
  int get activeIndex => _activeIndex;
  int get selectedLawyerScreenIndex => _selectedLawyerScreenIndex;
  int get selectedLawFirmScreenIndex => _selectedLawFirmScreenIndex;
  int get selectedCompanyScreenIndex => _selectedCompanyScreenIndex;
  int get selectedPIScreenIndex => _selectedPIScreenIndex;
  List get onboardingItems => _onboardingItems;
  List get lawyerScreens => _lawyerScreens;
  List get lawFirmsScreens => _lawFirmsScreens;
  List get companyScreens => _companyScreens;
  List get piScreens => _piScreens;
  File? get selectedImage => _selectedImage;
  ImagePicker get imagePicker => _imagePicker;
  String get imageUrl => _imageUrl;
  bool get isLoading => _isLoading;
  List get notificationList => _notificationList;
  List get unseenNotifications => _unseenNotifications;

  // SETTERS
  updateActiveIndex(value) {
    _activeIndex = value;
    update();
  }
  updateselectedLawyerScreenIndex(value) {
    _selectedLawyerScreenIndex = value;
    update();
  }
  updateselectedLawFirmScreenIndex(value) {
    _selectedLawFirmScreenIndex = value;
    update();
  }
  updateselectedCompanyScreenIndex(value) {
    _selectedCompanyScreenIndex = value;
    update();
  }
  updateselectedPIScreenIndex(value) {
    _selectedPIScreenIndex = value;
    update();
  }
  updateImageUrl(value) {
    _imageUrl = value;
    update();
  }
  updateImage(value) {
    _selectedImage = value;
    update();
  }
  updateIsLoading(value) {
    _isLoading = value;
    update();
  }
  updateNotifcationList(value) {
    _notificationList = value;
    update();
  }

  // LAUNCH WHATSAPP
  launchWhatsApp() {
    final Uri whatsapp = Uri.parse("https://wa.me/08160908587");
    launchUrl(whatsapp);
  }

  // LAUNCH EMAIL
  launchEmail() async{
    String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
    }
    final Uri email = Uri(
      scheme: "mailto",
      path: "akintadeseun816@gmail.com",
      query: encodeQueryParameters(<String, String>{
        'subject': "Hello!!!",
      }),
    );

    (await canLaunchUrl(email))?
    launchUrl(email)
    :
    throw Exception("Could not launch url");

  }

  // PING SERVER
  Future<void> pingServer() async{

    var response = await PingApiService.pingServerService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      String userToken = await LocalStorage().fetchUserToken();

      (userToken == "")?
      Get.toNamed(onboardingScreen)
      :
      Get.offAllNamed(loginScreen);
      
    } else {
      Fluttertoast.showToast(
        msg: responseData["error"],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
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
    _unseenNotifications = _notificationList.where((unseen) => unseen["seen"] == true).toList();
    update();
  }
  
  
}