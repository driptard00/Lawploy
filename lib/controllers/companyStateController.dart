import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawploy_app/services/JOBS/jobs_api_services.dart';
import 'package:lawploy_app/services/PRIVATE-IND/private_api_services.dart';

import '../Widget/PopUps/otpPopUp.dart';
import '../models/corporationModel.dart';
import '../models/myJobModel.dart';
import '../models/other_lawyers_model.dart';
import '../routes/app_route_names.dart';
import '../services/COMPANY/company_api_services.dart';
import '../storage/secureStorage.dart';

class CompanyStateController extends GetxController {
  // INSTANT VARIABLES
  String _country = "";
  String _state = "";
  String _lga = "";
  String _email = "";
  String _password = "";
  String _companyName = "";
  String _companyPhoneNumber = "";
  String _companyWebsite = "";
  String _companyAddress = "";
  String _companyIndustryType = "";
  bool _hidePassword = true;
  String _confirmPassword = "";
  final List<String> _industryTypes = [
    "Consulting, IT, or business services",
    "Design, marketing or communication",
    "Travel, accommodation, or transport",
    "Health, sports or personal care",
    "Food, beverages, or tobacco",
    "Retail, wholesale or manufacturing ",
    "Financial services, or holding companies",
    "Real estate or construction",
    "Education",
    "Utilities and public or  government services",
    "Others",
  ];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  TextEditingController _industryTypeController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _companyPhoneNumberController = TextEditingController();
  TextEditingController _companyWebsiteController = TextEditingController();
  TextEditingController _companyAddressController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _lgaController = TextEditingController();
  Corporation _corporation = Corporation();
  String _imageUrl = "";
  ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  final cloudinary = Cloudinary.signedConfig(
    apiKey: "729881695894599",
    apiSecret: "iQLHhe3p7GDeb9qxVufzYLMO_G8",
    cloudName: "dxy0fr9yu",
  );
  List<dynamic> _lawyersList = [];
  List<dynamic> _adrLawyersList = [];
  List<dynamic> _corporateLawyersList = [];
  List<dynamic> _financeLawyersList = [];
  List<dynamic> _litigationLawyersList = [];
  List<dynamic> _oagLawyersList = [];
  List<dynamic> _myJobsList = [];
  List<dynamic> _applicants = [];
  OtherLawyer _otherLawyer = OtherLawyer();
  MyJob _myJob = MyJob();
  TextEditingController _codeController = TextEditingController();
  bool _isInAppNotificationActive = false;
  bool _isEmailNotificationActive = false;
  bool _isVisibilityOff = false;

  // GETTERS
  String get country => _country;
  String get state => _state;
  String get lga => _lga;
  String get companyName => _companyName;
  String get companyPhoneNumber => _companyPhoneNumber;
  String get companyWebsite => _companyWebsite;
  String get companyAddress => _companyAddress;
  String get companyIndustryType => _companyIndustryType;
  List get industryTypes => _industryTypes;
  TextEditingController get industryTypeController => _industryTypeController;
  TextEditingController get companyNameController => _companyNameController;
  TextEditingController get companyPhoneNumberController => _companyPhoneNumberController;
  TextEditingController get companyWebsiteController => _companyWebsiteController;
  TextEditingController get companyAddressController => _companyAddressController;
  TextEditingController get stateController =>_stateController;
  TextEditingController get countryController => _countryController;
  TextEditingController get lgaController => _lgaController;
  TextEditingController get codeController => _codeController;
  Corporation get corporation => _corporation;
  File? get selectedImage => _selectedImage;
  String get imageUrl => _imageUrl;
  List<dynamic> get lawyersList => _lawyersList;
  List<dynamic> get adrLawyersList => _adrLawyersList;
  List<dynamic> get corporateLawyersList => _corporateLawyersList;
  List<dynamic> get financeLawyersList => _financeLawyersList;
  List<dynamic> get litigationLawyersList => _litigationLawyersList;
  List<dynamic> get oagLawyersList => _oagLawyersList;
  List<dynamic> get myJobsList => _myJobsList;
  List<dynamic> get applicants => _applicants;
  OtherLawyer get otherLawyer => _otherLawyer;
  MyJob get myJob => _myJob;
  bool get isInAppNotificationActive => _isInAppNotificationActive;
  bool get isEmailNotificationActive => _isInAppNotificationActive;
  bool get isVisibilityOff => _isVisibilityOff;
  String get confirmPassword => _confirmPassword;
  bool get hidePassword => _hidePassword;
  String get password => _password;

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
  updateCodeController(value) {
    _codeController.text = value;
    update();
  }
  updateIndustryType(value) {
    _companyIndustryType = value;
    _industryTypeController.text = _companyIndustryType;
    Get.back();
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
  updateOAG(value) {
    _oagLawyersList = value;
    update();
  }
  updateMyJobsList(value) {
    _myJobsList = value;
    update();
  }
  updateApplicants(value) {
    _applicants = value;
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
          updateCompanyProfileImage(_imageUrl);
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

  //  COMPANY ONBOARDING SERVICE
  Future<void> companyOnboardingCreate() async{
    updateIsLoading(true);

    Map<String, dynamic> companyOnboardingDetails = {
      "name": _companyName,
      "area": _companyIndustryType,
      "phone_number_country_code": codeController.text,
      "phone_number": _companyPhoneNumber,
      "address": _companyAddress,
      "country": _country,
      "state": _state,
      "LGA": _lga,
      "website": _companyWebsite
    };

    var response = await CompanyApiServices.companyOnboardingService(companyOnboardingDetails);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
      Fluttertoast.showToast(
        msg: "Company Details Created Successfully!!!",
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
    update();
  }

  //  GET COMPANY PROFILE SERVICE
  Future<void> getCompanyProfile() async{
    updateIsLoading(true);

    var response = await CompanyApiServices.getCompanyProfileService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      _corporation = Corporation.fromMap(responseData["data"][0]);

      _industryTypeController.text = responseData["data"][0]["area"];
      _companyAddressController.text = responseData["data"][0]["address"];
      _companyPhoneNumberController.text = responseData["data"][0]["phone_number"];
      _countryController.text = responseData["data"][0]["country"];
      _companyNameController.text = responseData["data"][0]["name"];
      _stateController.text = responseData["data"][0]["state"];
      _lgaController.text = responseData["data"][0]["LGA"];
      // _companyWebsiteController.text = responseData["data"][0]["website"];
      _codeController.text = responseData["data"][0]["phone_number_country_code"];

      Get.toNamed(companyHolderScreen);

    } else {
      updateIsLoading(false);

    }
    update();
  }

  //  UPDATE COMPANY PROFILE SERVICE
  Future<void> updateCompanyProfile() async{
    updateIsLoading(true);

    Map<String, dynamic> updateCompanyProfileDetails = {
      "name": _companyNameController.text,
      "area": _industryTypeController.text,
      "phone_number_country_code": _codeController.text,
      "phone_number": _companyPhoneNumberController.text,
      "address": _companyAddressController.text,
      "country": _countryController.text,
      "state": _stateController.text,
      "LGA": _lgaController.text,
      "website": _companyWebsiteController.text
    };

    var response = await CompanyApiServices.updateCompanyProfile(updateCompanyProfileDetails);
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
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
    update();
  }

  //  UPDATE COMPANY PROFILE IMAGE SERVICE
  Future<void> updateCompanyPassword(BuildContext context) async{
    updateIsLoading(true);

    Map<String, dynamic> updateCompanyPasswordDetails = {
      "password": _password,
    };

    var response = await CompanyApiServices.updateCompanyPasswordService(updateCompanyPasswordDetails);
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
        Get.offNamed(companySettingsScreen);
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

  //  UPDATE COMPANY IN APP NOTIFICATION SERVICE
  Future<void> updateInAppNotification() async{
    updateIsLoading(true);

    var response = await CompanyApiServices.updateCompanyInAppNotificatonService();
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

     (_corporation.inAppNotifcations! == false) ?
     _corporation.inAppNotifcations = responseData["success"]
     :
    (_corporation.inAppNotifcations! == true) ?
     _corporation.inAppNotifcations = false
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

  //  UPDATE COMPANY EMAIL NOTIFICATION SERVICE
  Future<void> updateEmailNotification() async{
    updateIsLoading(true);

    var response = await CompanyApiServices.updateCompanyEmailNotificatonService();
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

    (_corporation.emailNotifcations! == false) ?
     _corporation.emailNotifcations = responseData["success"]
     :
    (_corporation.emailNotifcations! == true) ?
     _corporation.emailNotifcations = false
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

  //  UPDATE COMPANY VISIBILITY SERVICE
  Future<void> updateCompanyVisibility() async{
    updateIsLoading(true);

    var response = await CompanyApiServices.updateCompanyVisibilityService();
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      (_corporation.privateMode! == false) ?
      _corporation.privateMode = responseData["success"]
      :
      (_corporation.privateMode! == true) ?
      _corporation.privateMode = false
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

  //  UPDATE COMPANY PROFILE IMAGE SERVICE
  Future<void> updateCompanyProfileImage(String _imageUrl) async{
    updateIsLoading(true);

    Map<String, dynamic> updateCompanyProfileImageDetails = {
      "image": _imageUrl,
    };

    var response = await CompanyApiServices.updateCompanyProfileImage(updateCompanyProfileImageDetails);
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

  //  GET all lawyers
  Future<void> getAllLawyers() async{
    updateIsLoading(true);

    var response = await CompanyApiServices.companyGetAllLawyersService();
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

    var response = await CompanyApiServices.companyGetSingleLawyer(id);
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

  //  GET my jobs
  Future<void> getMyJobs() async{
    updateIsLoading(true);

    var response = await JobsApiServices.getMyJobsService();
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      updateMyJobsList(responseData["data"]);

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

  //  GET single my jobs
  Future<void> getSingleJob(String id) async{
    updateIsLoading(true);

    var response = await JobsApiServices.getSingleJobService(id);
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      _myJob = MyJob.fromMap(responseData["data"]);

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