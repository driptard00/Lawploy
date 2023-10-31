import 'dart:convert';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Widget/PopUps/otpPopUp.dart';
import '../models/myJobModel.dart';
import '../services/JOBS/jobs_api_services.dart';

class JobStateController extends GetxController {
  String _name = "";
  String _job_title = "";
  String _description = "";
  String _position_type = "";
  String _responsibilities = "";
  String _website = "";
  String _country = "";
  String _state = "";
  String _imageUrl = "https://www.seekpng.com/png/detail/46-462910_person-icon-black-avatar-png.png";
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
  List<dynamic> _countries = [];
  List<dynamic> _states = [];
  List<dynamic> _myJobList = [];
  List<dynamic> _applicants = [];
  MyJob _myJob = MyJob();


  // GETTERS
  String get name => _name;
  String get jobtitle => _job_title;
  String get description => _description;
  String get positiontype => _position_type;
  List get positionTypes => _positionTypes;
  String get responsibilities => _responsibilities;
  String get website => _website;
  String get country => _country;
  String get state => _state;
  File? get selectedImage => _selectedImage;
  TextEditingController get positionTypeController => _positionTypeController;
  bool get isLoading => _isLoading;
  List<dynamic> get countries => _countries;
  List<dynamic> get states => _states;
  List<dynamic> get myJobList => _myJobList;
  List<dynamic> get applicants => _applicants;
  MyJob get myJob => _myJob;

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
    (_positionTypeController.text != "") ?
    Get.back()
    :
    null;
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
  updateApplicants(value) {
    _applicants = value;
    update();
  }

  // READ COUNTRY AND STATE DATA 
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('lib/countries.json');
    final data = await json.decode(response);
    updateCountries(data);
  }
  
  // GET JOB IMAGE
  Future<void> getJobImage(ImageSource imageSource) async {
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

  //  CREATE JOB SERVICE
  Future<void> createJobService(BuildContext context) async{
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
      "image": _imageUrl
    };
    print(details);

    var response = await JobsApiServices.createJobsService(details);
    var responseData = response!.data;
    print(responseData);
    
    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: "Job Created Successfully!!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      PopUps.showPopUps(context, "images/breifSent.png", "Job Post Created", "You’ve successfully created a job post.", "Close", (){
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

}