import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawploy_app/models/lawyerModel.dart';
import 'package:lawploy_app/services/BRIEFS/briefs_api_services.dart';
import 'package:lawploy_app/services/JOBS/jobs_api_services.dart';
import 'package:lawploy_app/services/LAWYER/lawyer_api_services.dart';
import 'package:path/path.dart' as path;

import '../Widget/PopUps/otpPopUp.dart';
import '../models/jobFeedModel.dart';
import '../models/other_lawyers_model.dart';
import '../routes/app_route_names.dart';
import '../storage/secureStorage.dart';

class LawyerStateController extends GetxController {

  // ======= INSTANT VARIABLES ==========
  String _firstname = "";
  String _middlename = "";
  String _lastname = "";
  String _phonenumber = "";
  String _breifDescription = "";
  dynamic _minimumAmountForABrief = 0;
  String _selectedPracticeArea = "";
  dynamic _yearOfCall = 0;
  String _country = "";
  String _state = "";
  String _lga = "";
  String _email = "";
  String _password = "";
  bool _isLoading = false;
  bool _hidePassword = true;
  String _confirmPassword = "";
  String _coverLetterText = "";
  final List<String> _practiceAreas = [
    "Alternative Dispute Resolution (ARD)",
    "Corporate",
    "Finance",
    "Litigation",
    "Oil and Gas",
  ];
  final List<String> _availabilityOptions = [
    "Yes",
    "No"
  ];
  String _selectedTypeOption = "";
  String _selectedAvailability = "";
  TextEditingController _practiceAreaController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _middlenameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _minimumAmountForABriefController = TextEditingController();
  TextEditingController _yearOfCallController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _lgaController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  Lawyer _lawyer = Lawyer();
  OtherLawyer _otherLawyer = OtherLawyer();
  String _imageUrl = "";
  ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  // FirebaseStorage storage = FirebaseStorage.instanceFor(bucket: "gs://lawploy-c677e.appspot.com/images");
  final cloudinary = Cloudinary.signedConfig(
    apiKey: "729881695894599",
    apiSecret: "iQLHhe3p7GDeb9qxVufzYLMO_G8",
    cloudName: "dxy0fr9yu",
  );
  String _fileName = "";
  String _fileUrl = "";
  TextEditingController _fileNameController = TextEditingController();
  List<dynamic> _allActiveJobs = [];
  List<dynamic> _lawyersList = [];
  List<dynamic> _adrLawyersList = [];
  List<dynamic> _corporateLawyersList = [];
  List<dynamic> _financeLawyersList = [];
  List<dynamic> _litigationLawyersList = [];
  List<dynamic> _oagLawyersList = [];
  JobFeed _jobFeed = JobFeed();
  String _lawyerId = "";

  // GETTERS
  String get firstname => _firstname;
  String get lastname => _lastname;
  String get middlename => _middlename;
  String get phonenumber => _phonenumber;
  String get breifDescription => _breifDescription;
  dynamic get minimumAmountForABrief => _minimumAmountForABrief;
  String get selectedPracticeArea => _selectedPracticeArea;
  List get practiceAreas => _practiceAreas;
  dynamic get yearOfCall => _yearOfCall;
  String get country => _country;
  String get state => _state;
  String get lga => _lga;
  String get selectedTypeOption => _selectedTypeOption;
  String get selectedAvailability=> _selectedAvailability;
  TextEditingController get practiceAreaController => _practiceAreaController;
  TextEditingController get firstnameController => _firstnameController;
  TextEditingController get middlenameController => _middlenameController;
  TextEditingController get lastnameController => _lastnameController;
  TextEditingController get emailAddressController => _emailAddressController;
  TextEditingController get phonenumberController => _phonenumberController;
  TextEditingController get bioController => _bioController;
  TextEditingController get minimumAmountForABriefController => _minimumAmountForABriefController;
  TextEditingController get yearOfCallController => _yearOfCallController;
  TextEditingController get countryController => _countryController;
  TextEditingController get stateController => _stateController;
  TextEditingController get lgaController => _lgaController;
  TextEditingController get fileNameController => _fileNameController;
  TextEditingController get codeController => _codeController;
  bool get isLoading => _isLoading;
  Lawyer get lawyer => _lawyer;
  File? get selectedImage => _selectedImage;
  String get imageUrl => _imageUrl;
  String get fileName => _fileName;
  String get fileUrl => _fileUrl;
  List<dynamic> get allActiveJobs => _allActiveJobs;
  List<dynamic> get lawyersList => _lawyersList;
  List<dynamic> get adrLawyersList => _adrLawyersList;
  List<dynamic> get corporateLawyersList => _corporateLawyersList;
  List<dynamic> get financeLawyersList => _financeLawyersList;
  List<dynamic> get litigationLawyersList => _litigationLawyersList;
  List<dynamic> get oagLawyersList => _oagLawyersList;
  JobFeed get jobFeed => _jobFeed;
  OtherLawyer get otherLawyer => _otherLawyer;
  String get lawyerId => _lawyerId;
  String get confirmPassword => _confirmPassword;
  bool get hidePassword => _hidePassword;
  String get password => _password;
  String get coverLetterText => _coverLetterText;

  // SETTERS
  updateFirstname(value) {
    _firstname = value;
    update();
  }
  updateLastname(value) {
    _lastname = value;
    update();
  }
  updateMiddlename(value) {
    _middlename = value;
    update();
  }
  updateIsLoading(value) {
    _isLoading = value;
    update();
  }
  updateSelectedOption(value) {
    _selectedTypeOption = value;
    update();
  }
  updateSelectedPracticeArea(value) {
    _selectedPracticeArea = value;
    _practiceAreaController.text = _selectedPracticeArea;
    (_practiceAreaController.text != "")?
    Get.back()
    :
    null;
    update();
  }
  updatePhoneNumber(value) {
    _phonenumber = value;
    update();
  }
  updateBriefDescription(value) {
    _breifDescription = value;
    update();
  }
  updateMinimumAmount(value) {
    _minimumAmountForABrief = value;
    update();
  }
  updateYearOfCall(value) {
    _yearOfCall = value;
    update();
  }
  updateCountry(value) {
    _country = value;
    update();
  }
  updateState(value) {
    _state = value;
    update();
  }
  updateLGA(value) {
    _lga = value;
    update();
  }
  updateEmail(value) {
    _email = value;
    update();
  }
  updateImageUrl(value) async{
    _imageUrl = value;
    update();
  }
  updateImage(value) {
    _selectedImage = value;
    update();
  }
  updateFileName(value) {
    _fileNameController.text = value;
    update();
  }
  updateFileUrl(value) {
    _fileUrl = value;
    update();
  }
  updateAllActiveJobs(value) {
    _allActiveJobs = value;
    update();
  }
  updateLawyersList(value) {
    _lawyersList = value;
    update();
  }
  updateARD(value) {
    _adrLawyersList = value;
    update();
  }
  updateCorporate(value) {
    _corporateLawyersList = value;
    update();
  }
  updateFinance(value) {
    _financeLawyersList = value;
    update();
  }
  updateLitigation(value) {
    _litigationLawyersList = value;
    update();
  }
  updateOAG(value) {
    _oagLawyersList = value;
    update();
  }
  updateLawyer(value) {
    _oagLawyersList = value;
    update();
  }
  updateLawyerId(value) {
    _lawyerId = value;
    update();
  }
  updateCodeController(value) {
    _codeController.text = value;
    update();
  }
  toggleHidePassword() {
    _hidePassword = !_hidePassword;
    update();
  }
  updateConfirmPassword(value) {
    _confirmPassword = value;
    update();
  }
  updatePassword(value) {
    _password = value;
    update();
  }
  updateCoverLetterText(value) {
    _coverLetterText = value;
    update();
  }

  // GET FILE
  Future<void> getFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);
        print(file);
        updateFileName(file.path.split("/").last);

        final response = await cloudinary.upload(
          file: file.path,
          fileBytes: file.readAsBytesSync(),
          resourceType: CloudinaryResourceType.image,
          progressCallback: (count, total) {
          print(
          'Uploading image from file with progress: $count/$total');
          });
          if(response.isSuccessful) {
            print('Get your image from with ${response.secureUrl}');  
            updateFileUrl(response.secureUrl);
          }  

      } else {
        // User canceled the picker
        Fluttertoast.showToast(
          msg: "No file selected!!!",
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
  
  // GET IMAGE
  Future<void> getImageUrl(ImageSource imageSource) async {
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

        if(_imageUrl != ""){
          updateLawyerProfileImage(_imageUrl);
        } else {
          null;
        }
        

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

  // LAWYER ONBOARDING SERVICE
  Future<void> lawyerOnboarding() async{
    updateIsLoading(true);

    Map<String, dynamic> lawyerOnboardingDetails = {
      "last_name": _lastname,
      "first_name": _firstname,
      "middle_name": _middlename,
      "area": _selectedPracticeArea,
      "bio": _breifDescription,
      "phone_number_country_code": _codeController.text,
      "phone_number": _phonenumber,
      "brief_min_amount": "$_minimumAmountForABrief",
      "brief_min_Currency": "NGN",
      "year_of_call": "$_yearOfCall",
      "country": _country,
      "state": _state,
      "LGA": _lga,
    };
    print(lawyerOnboardingDetails);

    var response = await LawyerApiServices.lawyerOnboardingService(lawyerOnboardingDetails);
    var responseData = response!.data;
    print(responseData);


    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
      Fluttertoast.showToast(
        msg: "Lawyer Details Created Successfully!!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );
      Get.offAllNamed(lawyerprofileAvailabilityScreen);

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

  // GET LAWYER DETAILS SERVICE
  Future<void> getLawyerDetails() async{
    updateIsLoading(true);

    var response = await LawyerApiServices.getLawyerProfileService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      _lawyer = Lawyer.fromMap(responseData["data"]);

      String id = await LocalStorage().fetchUserId();
      await LocalStorage().storeUserAUTH(responseData["data"]["_auth"]);
      updateLawyerId(id);

      _firstnameController.text = responseData["data"]["first_name"];
      _lastnameController.text = responseData["data"]["last_name"];
      _middlenameController.text = responseData["data"]["middle_name"];
      _emailAddressController.text = responseData["data"]["email"];
      _phonenumberController.text = responseData["data"]["phone_number"];
      _bioController.text = responseData["data"]["bio"];
      _minimumAmountForABriefController.text = responseData["data"]["brief_min_amount"].toString();
      _practiceAreaController.text = responseData["data"]["area"];
      _yearOfCallController.text = responseData["data"]["year_of_call"].toString();
      _countryController.text = responseData["data"]["country"];
      _stateController.text = responseData["data"]["state"];
      _lgaController.text = responseData["data"]["LGA"];
      _codeController.text = responseData["data"]["phone_number_country_code"];

      Get.toNamed(lawyerHolderScreen);
      
    } else {
      updateIsLoading(false);
      Fluttertoast.showToast(
        msg: responseData["error"],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: const Color.fromARGB(255, 255, 199, 199),
        fontSize: 16.0
      );
    }
    update();
  }

  // UPDATE LAWYER DETAILS SERVICE
  Future<void> updateLawyerProfile() async{
    updateIsLoading(true);

    Map<String, dynamic> updateLawyerProfileDetails = {
      "last_name": _lastnameController.text,
      "first_name": _firstnameController.text,
      "middle_name": _middlenameController.text,
      "area": _practiceAreaController.text,
      "bio": _bioController.text,
      "phone_number_country_code": _codeController.text,
      "phone_number": _phonenumberController.text,
      "brief_min_amount": _minimumAmountForABriefController.text,
      "brief_min_Currency": "NGN",
      "year_of_call": _yearOfCallController.text,
      "country": _countryController.text,
      "state": _stateController.text,
      "LGA": _lgaController.text,
    };
    print(updateLawyerProfileDetails);

    var response = await LawyerApiServices.updateLawyerProfileService(updateLawyerProfileDetails);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
        Fluttertoast.showToast(
          msg: "Profile Updated Successfully!!!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
        );
    } else {
      updateIsLoading(false);
      Fluttertoast.showToast(
        msg: responseData["error"],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: const Color.fromARGB(255, 255, 199, 199),
        fontSize: 16.0
      );
    }
    update();
  }

  //  UPDATE LAWYER PROFILE IMAGE SERVICE
  Future<void> updateLawyerPassword(BuildContext context) async{
    updateIsLoading(true);

    Map<String, dynamic> updateLawyerPasswordDetails = {
      "password": _password,
    };

    var response = await LawyerApiServices.updateLawyerPasswordService(updateLawyerPasswordDetails);
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: "Password Updated Successfully!!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      PopUps.showPopUps(context, "images/Security.png", "Password Updated", "You’ve successfully updated your password", "Continue", (){
        Get.offNamed(lawyerSettingScreen);
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

  //  UPDATE LAWYER IN APP NOTIFICATION
  Future<void> updateLawyerInAppNotificaton() async{
    updateIsLoading(true);

    var response = await LawyerApiServices.updateLawyerInAppNotificatonService();
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      (_lawyer.inAppNotifcations! == false) ?
      _lawyer.inAppNotifcations = responseData["success"]
      :
      (_lawyer.inAppNotifcations! == true) ?
      _lawyer.inAppNotifcations = false
      :
      null;


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

  //  UPDATE LAWYER EMAIL NOTIFICATION SERVICE
  Future<void> updateLawyerEmailNotificaton() async{
    updateIsLoading(true);

    var response = await LawyerApiServices.updateLawyerEmailNotificatonService();
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      (_lawyer.emailNotifcations! == false) ?
      _lawyer.emailNotifcations = responseData["success"]
      :
      (_lawyer.emailNotifcations! == true) ?
      _lawyer.emailNotifcations = false
      :
      null;


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

  //  UPDATE VISIBLITY
  Future<void> updateVisibility() async{
    updateIsLoading(true);

    var response = await LawyerApiServices.updateLawyerVisibilityService();
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      (_lawyer.privateMode! == false) ?
      _lawyer.privateMode = responseData["success"]
      :
      (_lawyer.privateMode! == true) ?
      _lawyer.privateMode = false
      :
      null;

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

  //  UPDATE LAWYER PROFILE IMAGE SERVICE
  Future<void> updateLawyerProfileImage(String _imageUrl) async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "image": _imageUrl,
    };

    var response = await LawyerApiServices.updateLawyerProfileImageService(details);
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: "Image Updated Successfully!!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
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

  //  APPLY FOR A JOB
  Future<void> applyForAJob(BuildContext context, String id) async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "file": _fileUrl,
      "cover_letter": _coverLetterText
    };
    print(details);

    var response = await LawyerApiServices.applyForAJobService(details, id);
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      PopUps.showPopUps(
        context, 
        "images/breifSent.png", 
        "Application Sent", 
        "You’ve successfully applied for this job. You’ll be notified once the interview dat has been set",
        "Close", 
        (){
          Get.back();
        }
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

  //  GET APPLICATIONS
  Future<void> getJobApplications() async{
    updateIsLoading(true);

    var response = await LawyerApiServices.getMyApplicationService();
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

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

  //  GET one APPLICATION
  Future<void> getOneApplication(String id) async{
    updateIsLoading(true);

    var response = await LawyerApiServices.getOneApplicationService(id);
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

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

  //  GET All active jobs
  Future<void> getAllActiveJobs() async{
    updateIsLoading(true);

    var response = await JobsApiServices.getActiveJobsService();
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      updateAllActiveJobs(responseData["data"]);

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

  //  GET one active jobs
  Future<void> getOneActiveJobFeed(String id) async{
    updateIsLoading(true);

    var response = await JobsApiServices.getAJobService(id);
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      _jobFeed = JobFeed.fromMap(responseData["data"]);
      
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

  //  GET all lawyers
  Future<void> getAllLawyers() async{
    updateIsLoading(true);

    var response = await LawyerApiServices.getAllLawyersService();
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      updateLawyersList(responseData["data"]);
      updateARD(_lawyersList.where((element) => element["area"] == "Alternative Dispute Resolution (ARD)").toList());
      updateFinance(_lawyersList.where((element) => element["area"] == "Finance").toList());
      updateCorporate(_lawyersList.where((element) => element["area"] == "Corporate").toList());
      updateLitigation(_lawyersList.where((element) => element["area"] == "Litigation").toList());
      updateOAG(_lawyersList.where((element) => element["area"] == "Oil and Gas").toList());

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

  //  GET all lawyers
  Future<void> getSingleLawyer(String id) async{
    updateIsLoading(true);

    var response = await LawyerApiServices.getSingleLawyerService(id);
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      _otherLawyer = OtherLawyer.fromMap(responseData["data"]);
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

  //  GET shared briefs
  Future<void> getSharedBriefs() async{
    updateIsLoading(true);

    var response = await BriefsApiServices.getSharedBriefService();
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      _otherLawyer = OtherLawyer.fromMap(responseData["data"]);
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

  // LOGOUT AUTH
  Future<void> logoutAuth() async{
    await LocalStorage().deleteUserStorage();

    Fluttertoast.showToast(
      msg: "Logout Successful!!!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0
    );

    Get.offAllNamed(loginScreen);
  }

}