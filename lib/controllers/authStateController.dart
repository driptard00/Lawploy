import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lawploy_app/routes/api_routes.dart';
import 'package:lawploy_app/services/AUTH/auth_api_services.dart';
import 'package:lawploy_app/services/SWITCH%20ACCOUNT/switch_account_service.dart';
import 'package:lawploy_app/storage/secureStorage.dart';

import '../Widget/PopUps/otpPopUp.dart';
import '../routes/app_route_names.dart';

class AuthStateController extends GetxController {
  // INSTANT VARIABLES
  
  // ====== LAWYERS ======
  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  String _firstname = "";
  String _middlename = "";
  String _lastname = "";
  String _phonenumber = "";
  String _breifDescription = "";
  String _minimumAmountForABrief = "";
  String _selectedPracticeArea = "";
  String _yearOfCall = "";
  String _country = "";
  String _state = "";
  String _lga = "";
  String _companyName = "";
  String _companyPhoneNumber = "";
  String _companyWebsite = "";
  String _companyAddress = "";
  String _companyIndustryType = "";
  String _otp = "";
  String _positionType  = "";
  bool _hidePassword = true;
  bool _isLoading = false;
  final List<String> _typeOptions = [
    "Lawyer",
    "Law Firm",
    "Corporation",
    "Private Individual",
  ];
  final List<String> _practiceAreas = [
    "Alternative Dispute Resolution (ARD)",
    "Corporate",
    "Finance",
    "Litigation",
    "Oil and Gas",
  ];
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
  final List<String> _positionTypes = [
    "Part-Time Role",
    "Contract Role",
    "Full-Time Role",
  ];

  final List<String> _availabilityOptions = [
    "Yes",
    "No"
  ];
  String _selectedTypeOption = "";
  String _selectedAvailability = "";
  TextEditingController _codeController = TextEditingController();
  TextEditingController _practiceAreaController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _industryTypeController = TextEditingController();
  Map<String, dynamic> _allAccounts = {};
  String _selectedAccount = "";
  int _remainingSeconds = 120; // Initial countdown time in seconds
  late Timer _timer;



  // GETTERS
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get firstname => _firstname;
  String get lastname => _lastname;
  String get middlename => _middlename;
  String get phonenumber => _phonenumber;
  String get breifDescription => _breifDescription;
  String get minimumAmountForABrief => _minimumAmountForABrief;
  String get selectedPracticeArea => _selectedPracticeArea;
  String get yearOfCall => _yearOfCall;
  String get country => _country;
  String get state => _state;
  String get lga => _lga;
  String get companyName => _companyName;
  String get companyPhoneNumber => _companyPhoneNumber;
  String get companyWebsite => _companyWebsite;
  String get companyAddress => _companyAddress;
  String get companyIndustryType => _companyIndustryType;
  String get otp => _otp;
  bool get hidePassword => _hidePassword;
  bool get isLoading => _isLoading;
  List get typeOptions => _typeOptions;
  List get availabilityOptions => _availabilityOptions;
  List get practiceAreas => _practiceAreas;
  List get industryTypes => _industryTypes;
  List get positionTypes => _positionTypes;
  String get positionType => _positionType;
  String get selectedTypeOption => _selectedTypeOption;
  String get selectedAvailability=> _selectedAvailability;
  TextEditingController get codeController => _codeController;
  TextEditingController get practiceAreaController => _practiceAreaController;
  TextEditingController get emailController => _emailController;
  TextEditingController get industryTypeController => _industryTypeController;
  Map get allAccounts => _allAccounts;
  String get selectedAccount => _selectedAccount;
  int get remainingSeconds => _remainingSeconds;
  Timer get timer => _timer;

  // SETTERS
  updateEmail(value) {
    _email = value;
    update();
  }
  updatePassword(value) {
    _password = value;
    update();
  }
  updateConfirmPassword(value) {
    _confirmPassword = value;
    update();
  }
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
  toggleHidePassword() {
    _hidePassword = !_hidePassword;
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
  updateAvailability(value) {
    _selectedAvailability = value;
    update();
  }
  updateCodeController(value) {
    _codeController.text = value;
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
  updateOtp(value) {
    _otp = value;
    update();
  }
  updateSelectedPracticeArea(value) {
    _selectedPracticeArea = value;
    _practiceAreaController.text = _selectedPracticeArea;
    update();
  }
  updateIndustryType(value) {
    _companyIndustryType = value;
    _industryTypeController.text = _companyIndustryType;
    Get.back();
    update();
  }
  updatePositionTypes(value) {
    _positionType = value;
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
  fetchEmailFromStorage() async{
    _emailController.text = await LocalStorage().fetchEmail();
    update();
  }
  updateAllAccounts(value) {
    _allAccounts = value;
    update();
  }
  updateSelectedAccount(value) {
    _selectedAccount = value;
    update();
  }
  startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), updateTimer);
    update();
  }
  updateTimer(Timer timer) {
    if (_remainingSeconds > 0) {
      _remainingSeconds--;
    } else {
      _timer.cancel();
      onTimerFinished();
    }
    update();
  }
  onTimerFinished() {
    resendSignInOtp();
    update();
  }


  // REGISTER USER SERVICE
  Future<void> registerUser(BuildContext context) async{
    updateIsLoading(true);

    Map<String, dynamic> registerDetails = {
      "email": _email,
      "password": _password
    };
    print(registerDetails);

    var response = await ApiServices.registerUserService(registerDetails);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      await LocalStorage().storeEmail(_emailController.text);

      Fluttertoast.showToast(
        msg: "Registration Successful!!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      PopUps.showPopUps(context, "images/Message.png", "Check your email", "We’ve sent an OTP code to your email for verification.", "Continue", (){
        Get.offAllNamed(otpVerificationScreen);
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
          fontSize: 16.0);
    }
  }

  // LOGIN USER SERVICE
  Future<void> loginUser() async{
    updateIsLoading(true);

    String deviceToken = await LocalStorage().fetchDeviceID();

    Map<String, dynamic> loginDetails= {
      "email": _emailController.text,
      "password": _password,
      "device": deviceToken
    };

    print(loginDetails);

    var response = await ApiServices.loginUserService(loginDetails);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      await LocalStorage().storeEmail(_emailController.text);
      updateIsLoading(false);
      Fluttertoast.showToast(
        msg: "Login Successful!!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      await LocalStorage().storeUserToken(responseData["token"]);
      await LocalStorage().storeUserId(responseData["user"]["_id"]);

      if(responseData["user"]["account_setup_completed"] == false){
        Get.offAllNamed(typeOfAccountScreen);
      }
      else {
        await LocalStorage().storeUserToken(responseData["token"]);
        await LocalStorage().storeUserId(responseData["user"]["_id"]);
        await LocalStorage().storeUserAUTH(responseData["user"]["_auth"]);
        if(responseData["user"]["_type"] == "lawyer"){
          Get.offAllNamed(getLawyerDetailsScreen);
        } else if(responseData["user"]["_type"] == "firm"){
          Get.offAllNamed(getLawFirmDetailScreen);
        }else if(responseData["user"]["_type"] == "corporation"){
          Get.offAllNamed(getCompanyDetailsScreen);
        }else if(responseData["user"]["_type"] == "private"){
          Get.offAllNamed(getPrivateDetailsScreen);
        }else{
          Fluttertoast.showToast(
            msg: "Select a type!!!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
          );
        }
      }


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

  // RESEND SIGNIN OTP SERVICE
  Future<void> resendSignInOtp() async{
    updateIsLoading(true);

    Map<String, dynamic> resendDetails = {
      "email": _email,
    };

    var response = await ApiServices.resendRegisterOtpService(resendDetails);
    var responseData = response!.data;

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
      Fluttertoast.showToast(
        msg: "OTP sent Successfully!!!",
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
  }

  // FORGOT PASSWORD SERVICE
  Future<void> forgotPassword(BuildContext context) async{
    updateIsLoading(true);

    Map<String, dynamic> forgotPasswordDetails = {
      "email": _email,
    };

    var response = await ApiServices.forgotPasswordService(forgotPasswordDetails);
    var responseData = response!.data;

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
      Fluttertoast.showToast(
        msg: "Email sent Successfully!!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      PopUps.showPopUps(context, "images/Message.png", "Check your email", "We’ve sent an OTP code to your email to reset your password", "Continue", (){
        Get.toNamed(verifyEmailScreen);
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
  }

  // RESET PASSWORD SERVICE
  Future<void> resetPassword(BuildContext context) async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "password": _password,
    };

    var response = await ApiServices.resetPasswordService(details);
    var responseData = response!.data;

    bool isSuccess = responseData["success"];

    if(isSuccess){
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: "Password reset Successfully!!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      PopUps.showPopUps(
        context, 
        "images/Security.png",
        "Password Updated", 
        "Your password has been successfully updated", 
        "Continue", 
        (){
          Get.toNamed(loginScreen);
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
  }

  // VERIFY OTP (PASSWORD) SERVICE
  Future<void> verifyRegistrationOtp(BuildContext context) async{ 
    updateIsLoading(true);

    Map<String, dynamic> verifyRegOtpDetails = {
      "otp": _otp,
      "email": _email,
    };

    var response = await ApiServices.verifyRegistrationOtpService(verifyRegOtpDetails);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
      _timer.cancel();
      Fluttertoast.showToast(
        msg: "OTP Verified Successfully!!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );
      await LocalStorage().storeUserToken(responseData["token"]);
      PopUps.showPopUps(context, "images/Security.png", "Verification Successful", "Your email has been successfully verified.", "Continue", (){
        Get.offAllNamed(typeOfAccountScreen);
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
  }

  // VERIFY OTP (REGISTRATION) SERVICE
  Future<void> verifyPasswordOtp(BuildContext context) async{
    updateIsLoading(true);

    Map<String, dynamic> verifyPasswordOtpDetails = {
      "email": _email,
      "otp": _otp,
    };
    print(verifyPasswordOtpDetails);

    var response = await ApiServices.verifyPasswordOtpService(verifyPasswordOtpDetails);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
      _timer.cancel();
      Fluttertoast.showToast(
        msg: "OTP Verified Successfully!!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );
      await LocalStorage().storeUserToken(responseData["token"]);
      PopUps.showPopUps(context, "images/Security.png", "Verification Successful", "Your email has been successfully verified.", "Continue", (){
        Get.toNamed(createNewPassword);
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
  }

  // GET ALL ACCOUNTS
  Future<void> getAllAccounts() async{
    updateIsLoading(true);

    var response = await SwitchAccountService.getAllAccountsService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
      updateAllAccounts(responseData["data"]);

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

  // CREATE NEW ACCOUNT TYPE (COMPANY)
  Future<void> createNewAccountType1() async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "type": "corporation",
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

    print(details);

    var response = await SwitchAccountService.createNewAccountTypeServcie(details);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
      Fluttertoast.showToast(
        msg: "Account Created!!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      Get.offNamed(allAvailableAccountScreen);
    
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

  // CREATE NEW ACCOUNT TYPE (PRIVATE)
  Future<void> createNewAccountType2() async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "type": "private",
      "last_name": _lastname,
      "first_name":_firstname,
      "middle_name":_middlename,
      "phone_number_country_code": _codeController.text,
      "phone_number":_phonenumber
    };
    print(details);

    var response = await SwitchAccountService.createNewAccountTypeServcie(details);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
      Fluttertoast.showToast(
        msg: "Account Created!!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      Get.offNamed(allAvailableAccountScreen);
    
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

  // CREATE NEW ACCOUNT TYPE (LAWYER)
  Future<void> createNewAccountType3() async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "type": "lawyer",
      "last_name": _lastname,
      "first_name": _firstname,
      "middle_name": _middlename,
      "area": _selectedPracticeArea,
      "bio": _breifDescription,
      "phone_number_country_code": _codeController.text,
      "phone_number": _phonenumber,
      "brief_min_amount": _minimumAmountForABrief,
      "brief_min_Currency": "NGN",
      "year_of_call": _yearOfCall,
      "country": _country,
      "state": _state,
      "LGA": _lga,
    };

    print(details);

    var response = await SwitchAccountService.createNewAccountTypeServcie(details);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
      Fluttertoast.showToast(
        msg: "Account Created!!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      Get.offNamed(allAvailableAccountScreen);
    
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

  // CREATE NEW ACCOUNT TYPE (FIRM)
  Future<void> createNewAccountType4() async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "type": "firm",
      "name": _companyName,
      "phone_number_country_code": _codeController.text,
      "phone_number": _companyPhoneNumber,
      "address": _companyAddress,
      "country": _country,
      "state": _state,
      "LGA": _lga,
      "website": _companyWebsite
    };

    print(details);

    var response = await SwitchAccountService.createNewAccountTypeServcie(details);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
      Fluttertoast.showToast(
        msg: "Account Created!!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      Get.offNamed(allAvailableAccountScreen);
    
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

  // SWITCH ACCOUNT
  Future<void> switchAccount(String type) async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "type": type
    };

    print(details);

    var response = await SwitchAccountService.switchAccountService(details);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: 'Switch Successful',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      await LocalStorage().storeUserToken(responseData["token"]);
      await LocalStorage().storeUserId(responseData["user"]["_id"]);
      await LocalStorage().storeUserId(responseData["user"]["_auth"]);

      if(responseData["user"]["_type"] == "lawyer"){
        Get.offAllNamed(getLawyerDetailsScreen);
      } else if(responseData["user"]["_type"] == "firm"){
        Get.offAllNamed(getLawFirmDetailScreen);
      }else if(responseData["user"]["_type"] == "corporation"){
        Get.offAllNamed(getCompanyDetailsScreen);
      }else if(responseData["user"]["_type"] == "private"){
        Get.offAllNamed(getPrivateDetailsScreen);
      }else{
        Fluttertoast.showToast(
          msg: "Select a type!!!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
        );
      }


      

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

}