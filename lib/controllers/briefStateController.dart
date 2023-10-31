import 'dart:io';
import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_previewer/file_previewer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawploy_app/services/BRIEFS/briefs_api_services.dart';
import '../Widget/PopUps/otpPopUp.dart';
import '../storage/secureStorage.dart';

class BriefStateController extends GetxController {
  // instant variables
  String _briefName = "";
  String _imageUrl = "";
  String _briefText = "";
  bool _isLoading = false;
  ImagePicker _imagePicker = ImagePicker();
  File? _selectedFile;
  final cloudinary = Cloudinary.signedConfig(
    apiKey: "729881695894599",
    apiSecret: "iQLHhe3p7GDeb9qxVufzYLMO_G8",
    cloudName: "dxy0fr9yu",
  );
  List<dynamic> _myBriefsList = [];
  List<dynamic> _sharedBriefsList = [];
  Widget _thumbNail = Image.asset("");

  //getters
  String get briefName => _briefName;
  String get imageUrl => _imageUrl;
  String get briefText => _briefText;
  bool get isLoading => _isLoading;
  File? get selectedFile => _selectedFile;
  List<dynamic> get myBriefsList => _myBriefsList;
  List<dynamic> get sharedBriefsList => _sharedBriefsList;
  Widget get thumbNail => _thumbNail;

  // setters
  updateBriefName(value) {
    _briefName = value;
    update();
  }
  updateImageUrl(value) {
    _imageUrl = value;
    update();
  }
  updateFile(value) {
    _selectedFile = value;
    update();
  }
  updateBriefText(value) {
    _briefText = value;
    update();
  }
  updateIsLoading(value) {
    _isLoading = value;
    update();
  }
  updateMyBriefList(value) {
    _myBriefsList = value;
    _myBriefsList.sort((a, b) => DateTime.parse(b["createdAt"]).compareTo(DateTime.parse(a["createdAt"])));
    update();
  }
  updateSharedBriefs(value) {
    _sharedBriefsList = value;
    _sharedBriefsList.sort((a, b) => DateTime.parse(b["createdAt"]).compareTo(DateTime.parse(a["createdAt"])));
    update();
  }
  updateThumbNail(value) {
    _thumbNail = value;
    update();
  }


  // FIREBASE STORAGE
  Future<void> uploadFile(File file, String fileName) async {
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      final Reference storageRef = storage.ref().child('lawploy/$fileName');
      final UploadTask uploadTask = storageRef.putFile(file);

      // Wait for the upload task to complete
      await uploadTask.whenComplete(() {
        print('File uploaded successfully');
      });

      // Get the download URL of the uploaded file
      String downloadURL = await storageRef.getDownloadURL();

      updateImageUrl(downloadURL);
      
      print('Download URL: $downloadURL');
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  // GET BRIEFS IMAGE
  Future<void> getBriefFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);
        final thumbnail = await FilePreview.getThumbnail(file.path);

        updateFile(file);
        updateBriefName(file.path.split("/").last);
        updateThumbNail(thumbnail);

        // final response = await cloudinary.upload(
        //   file: file.path,
        //   fileBytes: file.readAsBytesSync(),
        //   resourceType: CloudinaryResourceType.image,
        //   progressCallback: (count, total) {
        //   print(
        //   'Uploading image from file with progress: $count/$total');
        //   });
        //   if(response.isSuccessful) {
        //     print('Get your image from with ${response.secureUrl}');  
        //     updateImageUrl(response.secureUrl);
        //   }  

        uploadFile(file, _briefName);

      } else {
        Fluttertoast.showToast(
          msg: "No brief image selected",
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

  // CREATE BRIEF SERVICE
  Future<void> createBrief(BuildContext context, String userId) async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "name":_briefName, // If Provide then URL is Required (Not required)
      "_path": _imageUrl, // If Provide then name Is Required (Not Required)
      "brief": _briefText, // Not required
      "_receiver": userId
    };

    print(details);

    var response = await BriefsApiServices.createBriefService(details);
    var responseData = response!.data;
    print(responseData);


    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);

      PopUps.showPopUps(context, "images/breifSent.png", "Brief Sent", "You’ve successfully sent your brief to the lawyer", "Close", (){
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
          fontSize: 16.0);
    }
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
      
      updateMyBriefList(responseData["data"]);

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

  // GET SHARED BRIEFS SERVICE
  Future<void> getSharedBriefs() async{
    updateIsLoading(true);

    var response = await BriefsApiServices.getSharedBriefService();
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess){
      updateIsLoading(false);
      
      updateSharedBriefs(responseData["data"]);

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

  // DELETE BRIEFS SERVICE
  Future<void> deleteMyBriefs(String userId) async{
    updateIsLoading(true);

    String userId = await LocalStorage().fetchUserId();

    var response = await BriefsApiServices.deleteBriefService(userId);
    var responseData = response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];

    if(isSuccess){
      updateIsLoading(false);

      Get.back();
      getSharedBriefs();

      Fluttertoast.showToast(
        msg: "Deleted!!!",
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
        fontSize: 16.0);
    }
  }

  void downloadFile(String filePath) async {
    var time = DateTime.now().millisecondsSinceEpoch;
    var path = "/storage/emulated/0/Download/image$time.jpg";
    var file = File(path);
    var res = await get(Uri.parse(filePath));
    file.writeAsBytesSync(res.bodyBytes);
  }
}