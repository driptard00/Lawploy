import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lawploy_app/screens/Main/Lawyers/views/Briefs/briefsScreen.dart';
import 'package:lawploy_app/screens/Main/Messages/messageScreen.dart';
import 'package:lawploy_app/services/BRIEFS/briefs_api_services.dart';
import 'package:lawploy_app/services/CHAT/chat_api_service.dart';
import 'package:lawploy_app/services/JOBS/jobs_api_services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Widget/PopUps/otpPopUp.dart';
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
import '../services/INTERVIEW/interview_flow_service.dart';
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
  List _unreadList = [];
  List _readList = [];
  List<dynamic> _conversationList = [];
  List<dynamic> _recievedList = [];
  List<dynamic> _sentList = [];
  List<dynamic> _acceptedList = [];
  List<dynamic> _myBriefList = [];
  List<dynamic> _unseen = [];
  List<dynamic> _sent = [];
  List<dynamic> _applicants = [];


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
  List get ureadList => _unreadList;
  List get unseen => _unseen;
  List get readList => _readList;
  List<dynamic> get conversationList => _conversationList;
  List<dynamic> get recievedList => _recievedList;
  List<dynamic> get acceptedList => _acceptedList;
  List get myBriefList => _myBriefList;
  List get sentList => _sentList;
  List get sent => _sent;
  List get applicants => _applicants;


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
    _notificationList.sort(((a, b) => DateTime.parse(a["createdAt"]).compareTo(DateTime.parse(b["createdAt"]))));
    update();
  }
  updateUnreadList(value) {
    _unreadList = value;
    update();
  }
  updateUnSeenList(value) {
    _unseen = value;
    update();
  }
  updateConversationList(value) {
    _conversationList = value;
    update();
  }
  updateReceivedList(value) {
    _recievedList = value;
    update();
  }
  updateAcceptedList(value) {
    _acceptedList = value;
    update();
  }
  updateReadList(value) {
    _readList = value;
    update();
  }
  updateSentList(value) {
    _sentList = value;
    update();
  }
  updateMyBriefList(value){
    _myBriefList = value;
    update();
  }
  updateSent(value){
    _sent = value;
    update();
  }
  updateApplicants(value){
    _sent = value;
    update();
  }

    String calculateTimeDifference(String createdAt) {
    final createdAtDateTime = DateTime.parse(createdAt);
    final now = DateTime.now();
    final difference = now.difference(createdAtDateTime);

    if (difference.inDays > 0) {
      return DateFormat('MMM d').format(createdAtDateTime);
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  // LAUNCH WHATSAPP
  launchWhatsApp() async{
    String url = "whatsapp://send?phone=+2348020835264&text=Hello";
    (await canLaunchUrl(Uri.parse(url)))?
    launchUrl(Uri.parse(url))
    :
    print("Can not open!!");
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
      path: "Contact@lawploy.com",
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
      // String userToken = await LocalStorage().fetchUserToken2();
      // String userType = await LocalStorage().fetchType();

      // if(userToken == ""){
      //   Get.toNamed(onboardingScreen);
      // } else {
      //   if(userType == "corporation"){
      //     Get.offAllNamed(companyHolderScreen);
      //   } else if (userType == "lawyer"){
      //     Get.offAllNamed(lawyerHolderScreen);
      //   }else if (userType == "firm"){
      //     Get.offAllNamed(lawFirmHolderScreen);
      //   } else if (userType == "private"){
      //     Get.offAllNamed(piHolderScreen);
      //   }
      // }


      
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
      updateUnreadList(
        _notificationList.where((notification) => notification["seen"] == false).toList()
      );

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
    print("UNSEENNNN::::: $_unseenNotifications");
    update();
  }

  

    // GET CONVERSATIONS
  Future<void> getConversations() async{
    // updateIsLoading(true);

    String auth = await LocalStorage().fetchUserAUTH();

    var response = await ChatApiServices.getConversationService();
    var responseData = await response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess) {
      // updateIsLoading(false);

      // updateChatId(responseData["data"]);

      updateConversationList(responseData["data"]);

      updateUnSeenList(
        _conversationList.where(
          (read) => read["lastMessage"] != null
        ).toList()
      );

      updateReadList(
        _unseen.where((read) => read["lastMessage"]["read"] == false && read["lastMessage"]["_sender"] != auth).toList()
      );

      
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

    update();
  }

  // MARK AS READ
  Future<void> markMessageRead(String chatID, userID) async{

    var response = await ChatApiServices.markMessageAsReadService(chatID, userID);
    var responseData = await response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess) {
      getConversations();
    } else {

      // Fluttertoast.showToast(
      //   msg: responseData["error"],
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      //   fontSize: 16.0
      // );
    }
  }

  
  //  GET ALL RECIEVED INTERVIEWS
  Future<void> getAllRecievedInterviews() async{
    updateIsLoading(true);

    var response = await InterviewFlowService.getAllRecievedInterviewsService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      updateReceivedList(responseData["data"]);
      updateAcceptedList(
        _recievedList.where((pending) => pending["state"] == "Pending").toList()
      );

      // updateFeedbacks(
      //   _recievedList.where((feedback) => feedback["feedback_state"] == true).toList()
      // );

    } else {
      updateIsLoading(false);

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

    update();
        
  }

  // GET MY BRIEFS SERVICE
  Future<void> getMyBriefs() async{
    updateIsLoading(true);

    var response = await BriefsApiServices.getMyBriefsService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
      
      updateMyBriefList(
        // responseData["data"].where((brief) => brief["createdAt"].toString().split("T").first == 
        // DateTime.now().toString().split(" ").first).toList()
        responseData["data"]
      );

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

  Future<void> launchGoogleMeet() async {
    const url = "https://meet.google.com/"; // Replace with your Google Meet URL or meeting code
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication
      );
    } else {
      throw 'Could not launch $url';
    }
  }
  
    //  GET ALL SENT INTERVIEWS
  Future<void> getAllSentInterviews() async{
    updateIsLoading(true);

    var response = await InterviewFlowService.getAllSentInterviewService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      updateSentList(
        _sentList = responseData["data"]
      );
      updateSent(
        _sentList.where((sent) => sent["state"] == "Pending").toList()
      );

    } else {
      updateIsLoading(false);

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
    update();
  }

  Future<void> getAllJobData() async{
    updateIsLoading(true);

    var response = await JobsApiServices.getAllJobDataService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      updateApplicants(responseData["applicants"]);
      print("APPLANTS: $_applicants");

    } else {
      updateIsLoading(false);

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
    update();
  }

  Future<void> acceptInterviewInvite(BuildContext context, String id, String state) async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "state": state
    };
    print(details);

    var response = await InterviewFlowService.acceptOrRejectRecievedInterviewService(details, id);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      (responseData["data"]["state"] == "Accepted")?
      PopUps.showPopUps(context, "images/breifSent.png", "Interview Invitation Accepted", "You’ve successfully accepted the interview. You’ll be notified a day before the interview.", "Continue", (){
        Get.back();
        Get.back();
        getAllRecievedInterviews();
      })
      :
      PopUps.showPopUps(context, "images/breifSent.png", "Interview Invitation Rejected", "You’ve rejected the interview. ${responseData["data"]["name"]} will be notified", "Continue", (){
        Get.back();
        Get.back();
        getAllRecievedInterviews();
      });

    } else {
      updateIsLoading(false);

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
    update();
  }


}