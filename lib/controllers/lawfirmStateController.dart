import 'dart:convert';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawploy_app/models/lawFirmModel.dart';
import 'package:lawploy_app/models/lawyerModel.dart';
import 'package:lawploy_app/routes/app_route_names.dart';
import 'package:lawploy_app/services/AUTH/auth_api_services.dart';
import 'package:lawploy_app/services/FIRM/lawFirmApiServices.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lawploy_app/services/JOBS/jobs_api_services.dart';
import 'package:lawploy_app/services/LAWYER/lawyer_api_services.dart';

import '../Widget/PopUps/otpPopUp.dart';
import '../models/other_lawyers_model.dart';
import '../storage/secureStorage.dart';

class LawFirmStateController extends GetxController {
  // INSTANT VARIABLES
  String _country = "";
  String _state = "";
  String _lga = "nil";
  String _companyName = "";
  String _companyPhoneNumber = "";
  String _companyWebsite = "";
  String _companyAddress = "";
  bool _isLoading = false;
  bool _isPayLoading = false;
  LawFirm _lawFirm = LawFirm();
  bool _hidePassword = true;
  String _confirmPassword = "";
  String _password = "";
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _companyPhoneNumberController = TextEditingController();
  TextEditingController _companyWebsiteController = TextEditingController();
  TextEditingController _companyAddressController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _lgaController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  String _imageUrl = "";
  ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  List<dynamic> _lawyersList = [];
  List<dynamic> _adrLawyersList = [];
  List<dynamic> _corporateLawyersList = [];
  List<dynamic> _financeLawyersList = [];
  List<dynamic> _litigationLawyersList = [];
  List<dynamic> _oagLawyersList = [];
  OtherLawyer _otherLawyer = OtherLawyer();
  List<dynamic> _applicants = [];
  List<dynamic> _countries = [];
  List<dynamic> _states = [];
  List<dynamic> _myJobList = [];


  // GETTERS
  String get country => _country;
  String get state => _state;
  String get lga => _lga;
  String get companyName => _companyName;
  String get companyPhoneNumber => _companyPhoneNumber;
  String get companyWebsite => _companyWebsite;
  String get companyAddress => _companyAddress;
  bool get isLoading => _isLoading;
  bool get isPayLoading => _isPayLoading;
  LawFirm get lawFirm => _lawFirm;
  TextEditingController get companyNameController => _companyNameController;
  TextEditingController get companyPhoneNumberController => _companyPhoneNumberController;
  TextEditingController get companyWebsiteController => _companyWebsiteController;
  TextEditingController get companyAddressController => _companyAddressController;
  TextEditingController get stateController =>_stateController;
  TextEditingController get countryController => _countryController;
  TextEditingController get lgaController => _lgaController;
  TextEditingController get codeController => _codeController;
  File? get selectedImage => _selectedImage;
  String get imageUrl => _imageUrl;
    final cloudinary = Cloudinary.signedConfig(
    apiKey: "729881695894599",
    apiSecret: "iQLHhe3p7GDeb9qxVufzYLMO_G8",
    cloudName: "dxy0fr9yu",
  );
  List<dynamic> get lawyersList => _lawyersList;
  List<dynamic> get adrLawyersList => _adrLawyersList;
  List<dynamic> get corporateLawyersList => _corporateLawyersList;
  List<dynamic> get financeLawyersList => _financeLawyersList;
  List<dynamic> get litigationLawyersList => _litigationLawyersList;
  List<dynamic> get oagLawyersList => _oagLawyersList;
  List<dynamic> get applicants => _applicants;
  OtherLawyer get otherLawyer => _otherLawyer;
  String get confirmPassword => _confirmPassword;
  bool get hidePassword => _hidePassword;
  String get password => _password;
  List<dynamic> get countries => _countries;
  List<dynamic> get states => _states;
  List<dynamic> get myJobList => _myJobList;


  // SETTERS
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
  updateCompanyName(value) {
    _companyName = value;
    update();
  }
  updateCompanyPhoneNumber(value) {
    _companyPhoneNumber = value;
    update();
  }
  updateCompanyWebsite(value) {
    _companyWebsite = value;
    update();
  }
  updateCompanyAddress(value) {
    _companyAddress = value;
    update();
  }
  updateIsLoading(value) {
    _isLoading = value;
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
  updateApplicants(value) {
    _applicants = value;
    _applicants.sort((a, b) => DateTime.parse(b["createdAt"]).compareTo(DateTime.parse(a["createdAt"])));
    print("APPLICANTSS::::$applicants");
    update();
  }
  updateOAG(value) {
    _oagLawyersList = value;
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
  updateCountries(value) {
    _countries = value;
    update();
  }
  updateStates(value) {
    _states = value;
    update();
  }
  updateMyJobList(value) {
    _myJobList = value;
    update();
  }

  
  // READ COUNTRY AND STATE DATA 
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('lib/countries.json');
    final data = await json.decode(response);
    updateCountries(data);
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
          updateLawFirmProfileImage(_imageUrl);
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

  //  firm ONBOARDING SERVICE
  Future<void> lawFirmOnboardingCreate() async{
    updateIsLoading(true);

    Map<String, dynamic> lawFirmOnboardingDetails = {
      "name": _companyName,
      "phone_number_country_code": _codeController.text,
      "phone_number": _companyPhoneNumber,
      "address": _companyAddress,
      "country": _country,
      "state": _state,
      "LGA": _lga,
      "website": _companyWebsite
    };

    var response = await LawFirmApiServices.lawFirmOnboardingService(lawFirmOnboardingDetails);
    var responseData = response!.data;

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
      Fluttertoast.showToast(
        msg: "Firm Details Created Successfully!!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      Get.offAllNamed(loginScreen);


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
  }

  //  firm edit profile 
  Future<void> editFirmProfile() async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "name": _companyNameController.text,
      "phone_number_country_code": _codeController.text,
      "phone_number": _companyPhoneNumberController.text,
      "address": _companyAddressController.text,
      "country": _countryController.text,
      "state": _stateController.text,
      "LGA": _lgaController.text,
      "website": _companyWebsiteController.text
    };

    var response = await LawFirmApiServices.updateFirmProfileService(details);
    var responseData = response!.data;

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
      Fluttertoast.showToast(
        msg: "Firm Details Updated Successfully!!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      getLawFirmProfile();

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
  }

  //  GET FIRM PROFILE SERVICE
  Future<void> getLawFirmProfile() async{
    updateIsLoading(true);

    var response = await LawFirmApiServices.getLawFirmProfileService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      _lawFirm = LawFirm.fromMap(responseData["data"][0]);
      
      _companyAddressController.text = responseData["data"][0]["address"];
      _companyPhoneNumberController.text = responseData["data"][0]["phone_number"];
      _countryController.text = responseData["data"][0]["country"];
      _companyNameController.text = responseData["data"][0]["name"];
      _stateController.text = responseData["data"][0]["state"];
      _lgaController.text = responseData["data"][0]["LGA"];
      _codeController.text = responseData["data"][0]["phone_number_country_code"];


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
  }

  //  UPDATE FIRM IN APP NOTIFICATION SERVICE
  Future<void> updateFirmInAppNotifcation() async{
    updateIsLoading(true);

    var response = await LawFirmApiServices.updateFirmInAppNotificatonService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      (_lawFirm.inAppNotifcations! == false) ?
     _lawFirm.inAppNotifcations = responseData["success"]
     :
    (_lawFirm.inAppNotifcations! == true) ?
     _lawFirm.inAppNotifcations = false
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
  }

  //  UPDATE FIRM IN EMAIL NOTIFICATION SERVICE
  Future<void> updateFirmInEmaillNotifcation() async{
    updateIsLoading(true);

    var response = await LawFirmApiServices.updateFirmEmailNotificatonService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

    (_lawFirm.emailNotifcations! == false) ?
     _lawFirm.emailNotifcations = responseData["success"]
     :
    (_lawFirm.emailNotifcations! == true) ?
     _lawFirm.emailNotifcations = false
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
  }

  //  UPDATE FIRM VISIBILITY
  Future<void> updateVisibility() async{
    updateIsLoading(true);

    var response = await LawFirmApiServices.updateFirmVisibilityService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

    (_lawFirm.privateMode! == false) ?
     _lawFirm.privateMode = responseData["success"]
     :
    (_lawFirm.privateMode! == true) ?
     _lawFirm.privateMode = false
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
  }

  //  UPDATE Lawyer PROFILE IMAGE SERVICE
  Future<void> updateLawFirmProfileImage(String _imageUrl) async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "image": _imageUrl,
    };

    var response = await LawFirmApiServices.updateProfileImageService(details);
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

  //  UPDATE LawyerFirm Password SERVICE
  Future<void> updateLawFirmPassword(context) async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "password": _password,
    };

    var response = await LawFirmApiServices.updateLawFirmPasswordService(details);
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
        Get.offNamed(lawFirmSettingScreen);
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

  //  GET all lawyers
  Future<void> getAllLawyers() async{
    updateIsLoading(true);

    var response = await LawFirmApiServices.firmGetAllLawyersService();
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

    var response = await LawFirmApiServices.firmGetSingleLawyer(id);
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
    updateIsLoading(true);

    var response = await ApiServices.logoutUserService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
    updateIsLoading(false);

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
      
    } else {
    updateIsLoading(false);

      Fluttertoast.showToast(
        msg: "Logout Failed",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }

    //  GET my jobs
  Future<void> getAllJobData() async{
    updateIsLoading(true);

    var response = await JobsApiServices.getAllJobDataService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      updateApplicants(responseData["applicants"]);

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

  //  GET my jobs
  Future<void> getMyJobs() async{
    updateIsLoading(true);

    var response = await JobsApiServices.getMyJobsService();
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      updateMyJobList(responseData["data"]);

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

 
  //  deleteJob
  Future<void> deleteMyJob(String id) async{
    updateIsLoading(true);

    var response = await JobsApiServices.deleteJobService(id);
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      Get.back();
      getMyJobs();
      
      Fluttertoast.showToast(
        msg: "Job Deleted Successfully!",
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

}