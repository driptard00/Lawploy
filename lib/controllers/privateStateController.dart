import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawploy_app/models/privateModel.dart';
import 'package:lawploy_app/services/AUTH/auth_api_services.dart';

import '../Widget/PopUps/otpPopUp.dart';
import '../models/myJobModel.dart';
import '../models/other_lawyers_model.dart';
import '../routes/app_route_names.dart';
import '../services/JOBS/jobs_api_services.dart';
import '../services/PRIVATE-IND/private_api_services.dart';
import '../storage/secureStorage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PrivateStateController extends GetxController {

  // ======= INSTANT VARIABLES ==========
  String _firstname = "";
  String _middlename = "";
  String _lastname = "";
  String _phonenumber = "";
  String _email = "";
  bool _isLoading = false;
  PrivateIndividual _privateIndividual = PrivateIndividual();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _middlenameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  String _imageUrl = "";
  ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  final cloudinary = Cloudinary.signedConfig(
    apiKey: "729881695894599",
    apiSecret: "iQLHhe3p7GDeb9qxVufzYLMO_G8",
    cloudName: "dxy0fr9yu",
  );
  OtherLawyer _otherLawyer = OtherLawyer();
  List<dynamic> _lawyersList = [];
  List<dynamic> _adrLawyersList = [];
  List<dynamic> _corporateLawyersList = [];
  List<dynamic> _financeLawyersList = [];
  List<dynamic> _litigationLawyersList = [];
  List<dynamic> _oagLawyersList = [];
  bool _hidePassword = true;
  String _confirmPassword = "";
  String _password = "";
  List<dynamic> _myJobsList = [];
  List<dynamic> _applicants = [];
  MyJob _myJob = MyJob();


  // GETTERS
  String get firstname => _firstname;
  String get lastname => _lastname;
  String get middlename => _middlename;
  String get phonenumber => _phonenumber;
  String get email => _email;
  bool get isLoading => _isLoading;
  TextEditingController get firstnameController => _firstnameController;
  TextEditingController get middlenameController => _middlenameController;
  TextEditingController get lastnameController => _lastnameController;
  TextEditingController get emailAddressController => _emailAddressController;
  TextEditingController get phonenumberController => _phonenumberController;
  TextEditingController get codeController => _codeController;
  PrivateIndividual get privateIndividual => _privateIndividual;
  File? get selectedImage => _selectedImage;
  List<dynamic> get lawyersList => _lawyersList;
  List<dynamic> get adrLawyersList => _adrLawyersList;
  List<dynamic> get corporateLawyersList => _corporateLawyersList;
  List<dynamic> get financeLawyersList => _financeLawyersList;
  List<dynamic> get litigationLawyersList => _litigationLawyersList;
  List<dynamic> get oagLawyersList => _oagLawyersList;
  OtherLawyer get otherLawyer => _otherLawyer;
  String get confirmPassword => _confirmPassword;
  bool get hidePassword => _hidePassword;
  String get password => _password;
  List<dynamic> get myJobsList => _myJobsList;
  List<dynamic> get applicants => _applicants;
  MyJob get myJob => _myJob;


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
  updatePhoneNumber(value) {
    _phonenumber = value;
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
  updateMyJobsList(value) {
    _myJobsList = value;
    update();
  }
  updateApplicants(value) {
    _applicants = value;
    _applicants.sort((a, b) => DateTime.parse(b["createdAt"]).compareTo(DateTime.parse(a["createdAt"])));
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
          updatePrivateProfileImage(_imageUrl);
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

  // PRIVATE ONBOARDING SERVICE
  Future<void> privateOnboarding() async{
    updateIsLoading(true);

    Map<String, dynamic> privateOnboardingService = {
      "last_name": _lastname,
      "first_name":_firstname,
      "middle_name":_middlename,
      "phone_number_country_code": _codeController.text,
      "phone_number":_phonenumber
    };
    print(privateOnboardingService);

    var response = await PrivateApiServices.privateOnboardingService(privateOnboardingService);
    var responseData = response!.data;
    print(responseData);


    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
      Fluttertoast.showToast(
        msg: "Individual Details Created Successfully!!!",
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

  // GET PRIVATE DETAILS SERVICE
  Future<void> getPrivateDetails() async{
    updateIsLoading(true);

    var response = await PrivateApiServices.getPrivateProfileService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      _privateIndividual = PrivateIndividual.fromJson(responseData["data"][0]);

      _firstnameController.text = responseData["data"][0]["first_name"];
      _lastnameController.text = responseData["data"][0]["last_name"];
      _middlenameController.text = responseData["data"][0]["middle_name"];
      _emailAddressController.text = responseData["data"][0]["email"];
      _phonenumberController.text = responseData["data"][0]["phone_number"];
      _codeController.text = responseData["data"][0]["phone_number_country_code"];

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

  // PRIVATE ONBOARDING SERVICE
  Future<void> updatePrivateProfile() async{
    updateIsLoading(true);

    Map<String, dynamic> privateProfileDetails = {
      "last_name": _lastnameController.text,
      "first_name":_firstnameController.text,
      "middle_name":_middlenameController.text,
      "phone_number_country_code": _codeController.text,
      "phone_number":_phonenumberController.text
    };
    print(privateProfileDetails);

    var response = await PrivateApiServices.privateOnboardingService(privateProfileDetails);
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

      getPrivateDetails();

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

  //  UPDATE PRIVATE PROFILE IMAGE SERVICE
  Future<void> updatePrivateProfileImage(String _imageUrl) async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "image": _imageUrl,
    };

    var response = await PrivateApiServices.updatePrivateProfileImageService(details);
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

  //  UPDATE PRIVATE PASSWORD
  Future<void> updatePrivatePassword(context) async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "password": _password,
    };

    var response = await PrivateApiServices.updatePrivatePasswordService(details);
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
        Get.offNamed(privateSettingsScreen);
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

  //  UPDATE IN APP NOTIFICATION
  Future<void> updateInAppNotification() async{
    updateIsLoading(true);

    var response = await PrivateApiServices.updatePrivateInAppNotificatonService();
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      (privateIndividual.inAppNotifcations! == false) ?
      privateIndividual.inAppNotifcations = responseData["success"]
      :
      (privateIndividual.inAppNotifcations! == true) ?
      privateIndividual.inAppNotifcations = false
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

  //  UPDATE PRIVATE PROFILE IMAGE SERVICE
  Future<void> updateInEmailNotification() async{
    updateIsLoading(true);


    var response = await PrivateApiServices.updatePrivateEmailNotificatonService();
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      
      (privateIndividual.emailNotifcations! == false) ?
      privateIndividual.emailNotifcations = responseData["success"]
      :
      (privateIndividual.emailNotifcations! == true) ?
      privateIndividual.emailNotifcations = false
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

  Future<void> getAllLawyers() async{
    updateIsLoading(true);

    var response = await PrivateApiServices.privateGetAllLawyersService();
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

    var response = await PrivateApiServices.privateGetSingleLawyer(id);
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
}