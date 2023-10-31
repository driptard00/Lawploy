import 'dart:convert';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lawploy_app/services/INTERVIEW/interview_flow_service.dart';

import '../Widget/PopUps/otpPopUp.dart';
import '../services/JOBS/jobs_api_services.dart';

class InterviewStateController extends GetxController {
  String _name = "";
  String _job_title = "";
  String _description = "";
  String _position_type = "";
  String _responsibilities = "";
  String _website = "";
  String _country = "";
  String _state = "";
  String _imageUrl = "https://www.seekpng.com/png/detail/46-462910_person-icon-black-avatar-png.png";
  String _feedbackText = "";
  String _referenceLetterText = "";
  bool _isLoading = false;
  final List<String> _positionTypes = [
    "Part-Time Role",
    "Contract Role",
    "Full-Time Role",
  ];
  File? _selectedImage;
  final cloudinary = Cloudinary.signedConfig(
    apiKey: "729881695894599",
    apiSecret: "iQLHhe3p7GDeb9qxVufzYLMO_G8",
    cloudName: "dxy0fr9yu",
  );
  ImagePicker _imagePicker = ImagePicker();
  TextEditingController _positionTypeController = TextEditingController();
  List<dynamic> _allSentInterviews = [];
  List<dynamic> _allRecievedInterviews = [];
  Map<String, dynamic> _recievedInterview = {};
  Map<String, dynamic> _sentInterview = {};
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  String _dateOfInterview = "";
  TimeOfDay _timeOfDay = TimeOfDay(hour: 8, minute: 30);
  List<dynamic> _feedbacks = [];
  List<dynamic> _countries = [];
  List<dynamic> _states = [];


  // getters
  String get name => _name;
  String get jobtitle => _job_title;
  String get description => _description;
  String get positiontype => _position_type;
  List get positionTypes => _positionTypes;
  String get responsibilities => _responsibilities;
  String get website => _website;
  String get country => _country;
  String get state => _state;
  String get feedBackText => _feedbackText;
  String get referenceLetterText => _referenceLetterText;
  File? get selectedImage => _selectedImage;
  TextEditingController get positionTypeController => _positionTypeController;
  bool get isLoading => _isLoading;
  List get allSentInterviews => _allSentInterviews;
  List get allRecievedInterviews => _allRecievedInterviews;
  Map get recievedInterview => _recievedInterview;
  Map get sentInterview => _sentInterview;
  TextEditingController get dateController => _dateController;
  TextEditingController get timeController => _timeController;
  String get dateOfInterview => _dateOfInterview;
  TimeOfDay get timeOfDay => _timeOfDay;
  List get feedbacks => _feedbacks;
  List<dynamic> get countries => _countries;
  List<dynamic> get states => _states;


  // SETTERS
  updateName(value){
    _name = value;
    update();
  }
  updateJobTitle(value){
    _job_title = value;
    update();
  }
  updateDescription(value){
    _description = value;
    update();
  }
  updatePositionType(value){
    _position_type = value;
    _positionTypeController.text = _position_type;
    update();
  }
  updateResponsibilities(value){
    _responsibilities = value;
    update();
  }
  updateWebsite(value){
    _website = value;
    update();
  }
  updateCountry(value){
    _country = value;
    update();
  }
  updateState(value){
    _state = value;
    update();
  }
  updateIsLoading(value){
    _isLoading = value;
    update();
  }
  updateImageUrl(value){
    _imageUrl = value;
    update();
  }
  updateImage(value) {
    _selectedImage = value;
    update();
  }
  updateAllSentInterviews(value) {
    _allSentInterviews = value;
    update();
  }
  updateAllRecievedInterviews(value) {
    _allRecievedInterviews = value;
    update();
  }
  updateFeedbacktext(value) {
    _feedbackText = value;
    update();
  }
  updateReferenceLetterText(value) {
    _referenceLetterText = value;
    update();
  }
  updateSingleRecievedInterview(value) {
    _recievedInterview = value;
    update();
  }
  updateSingleSentInterview(value) {
    _sentInterview = value;
    update();
  }
  updateDateController(value) {
    _dateController.text = value;
    update();
  }
  updateDateOfInterview(value) {
    _dateOfInterview = value;
    update();
  }
  updateFeedbacks(value) {
    _feedbacks = value;
    update();
  }
  updateCountries(value) {
    _countries = value;
    update();
  }
  updateStates(value) {
    _states = value;
    update();
  }


  // READ COUNTRY AND STATE DATA 
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('lib/countries.json');
    final data = await json.decode(response);
    updateCountries(data);
  }
  
  // Date Picker
  Future<void> showDateTimePicker (BuildContext context) async{
    var dateOfInterview = await showDatePicker(
      context: context,
      initialDate: (_dateController.text.isNotEmpty) ?
      (DateTime.parse(_dateController.text)) :
      (DateTime.now()),
      firstDate: DateTime(1950, 01, 01),
      lastDate: DateTime(2023, 01, 01).add(const Duration(days: 365)),
    );
    if(dateOfInterview != null){
      DateFormat dateFormat = DateFormat("yyyy/MM/dd");
      String formattedDate = dateFormat.format(dateOfInterview);
      updateDateController(formattedDate);
      print(dateOfInterview);
      // updateDateOfInterview(formattedDate);
    }

    update();
  }

  Future<void> displayTimePicker (BuildContext context) async{
    var timeOfInterview = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    ).then((value) {
      _timeController.text = "${value!.hour}:${value.minute.toString().padLeft(2, "0")}";
    });
  }

  //  GET single my jobs
  Future<void> getSingleJob(String id) async{
    updateIsLoading(true);

    var response = await JobsApiServices.getSingleJobService(id);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      updateName(responseData["data"]["name"]);
      updateJobTitle(responseData["data"]["job_title"]);
      updateDescription(responseData["data"]["description"]);
      updateWebsite(responseData["data"]["website"]);
      updateResponsibilities(responseData["data"]["responsibilities"]);
      updateCountry(responseData["data"]["country"]);
      updateState(responseData["data"]["state"]);
      updateImageUrl(responseData["data"]["image"]);
      updatePositionType(responseData["data"]["position_type"]);

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


  // GET IMAGE
  Future<void> getImage(ImageSource imageSource) async {
    try {
      var _pickedImage = await _imagePicker.pickImage(
        source: imageSource,
      );
      if (_pickedImage != null) {
        updateImage(File(_pickedImage.path));
        final response = await cloudinary.upload(
            file: _selectedImage!.path,
            fileBytes: _selectedImage!.readAsBytesSync(),
            resourceType: CloudinaryResourceType.image,
            progressCallback: (count, total) {
              print(
                  'Uploading image from file with progress: $count/$total');
            });
        if(response.isSuccessful) {
          print('Get your image from with ${response.secureUrl}');
        }

        updateImageUrl(response.secureUrl);

        print("IMAGE URL::::::$_imageUrl");

      } else {
        Fluttertoast.showToast(
            msg: "No image selected",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 15.0
        );
      }
    } on PlatformException catch (e) {
      print(e);
    }

    update();
  }

  //  SEND INTERVIEW INVITE
  Future<void> sendInterviewInvite(BuildContext context, String _recevierAuth) async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "name": _name,
      "job_title": _job_title,
      "description": _description,
      "position_type": _position_type,// [Part-Time Role, Contract Role, Full-Time Role]
      "responsibilities": _responsibilities,// Hope u guys us Markdown to format
      "website": _website,
      "country": _country,
      "state": _state,
      "image": _imageUrl,
      "recevier": _recevierAuth,
      "time":_timeController.text,
      "day":_dateController.text
    };
    print(details);

    var response = await InterviewFlowService.sendInterviewInviteService(details);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      PopUps.showPopUps(context, "images/Message.png", "Invitation Sent", "Interview details has been sent to the applicant. You’ll be notified once they accept the invitation", "Continue", (){
        Get.back();
        Get.back();
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

  //  GET ALL SENT INTERVIEWS
  Future<void> getAllSentInterviews() async{
    updateIsLoading(true);

    var response = await InterviewFlowService.getAllSentInterviewService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      updateAllSentInterviews(responseData["data"]);

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

  //  GET ALL RECIEVED INTERVIEWS
  Future<void> getAllRecievedInterviews() async{
    updateIsLoading(true);

    var response = await InterviewFlowService.getAllRecievedInterviewsService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      updateAllRecievedInterviews(responseData["data"]);

      updateFeedbacks(
        _allRecievedInterviews.where((feedback) => feedback["feedback_state"] == true).toList()
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

  //  SEND FEEDBACK
  Future<void> sendFeedBack(BuildContext context, String id) async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "feedback": _feedbackText,
      "reference": _referenceLetterText
    };
    print(details);

    var response = await InterviewFlowService.sendFeedbackService(details, id);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      PopUps.showPopUps(context, "images/Pencil.png", "Feedback Sent!", "You’ve successfully sent a feedback to the applicant.", "Continue", (){
        Get.back();
        Get.back();
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

  //  ACCEPT AN INTERVIEW
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

  //  GET SINGLE SENT INTERVIEW
  Future<void> getSingleSentInterview(String id) async{
    updateIsLoading(true);

    var response = await InterviewFlowService.getSingleSentInterviewService(id);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      updateSingleSentInterview(responseData["data"]);

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

  //  GET SINGLE RECIEVED INTERVIEW
  Future<void> getSingleRecievedInterview(String id) async{
    updateIsLoading(true);

    var response = await InterviewFlowService.getSingleRecievedInterviewService(id);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      updateSingleRecievedInterview(responseData["data"]);

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