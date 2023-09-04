import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_previewer/file_previewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lawploy_app/routes/api_routes.dart';
import 'package:lawploy_app/services/CHAT/chat_api_service.dart';
import 'package:lawploy_app/storage/secureStorage.dart';
import '../models/chat_model.dart';
import '../routes/app_route_names.dart';

class ChatController extends GetxController {
  bool _isLoading = false;
  String _chatId = "";
  String _messageText = "";
  TextEditingController _msgController = TextEditingController();
  List<dynamic> _conversationList = [];
  List<dynamic> _allMessagesList = [];
  String _userId = "";
  String _usersAuth = "";
  String _fileName = "";
  String _fileUrl = "";
  final cloudinary = Cloudinary.signedConfig(
    apiKey: "729881695894599",
    apiSecret: "iQLHhe3p7GDeb9qxVufzYLMO_G8",
    cloudName: "dxy0fr9yu",
  );
  ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  String _imageUrl = "";
  String _readID = "";
  bool _online = false;
  String _lastSeen = "";
  bool _isEmojiVisisble = false;
  FocusNode _focusNode = FocusNode();
  Widget _thumbNail = Image.asset("");

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _focusNode.addListener(() {
      if(_focusNode.hasFocus) {
        _isEmojiVisisble = false;
      }
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  // GETTERS
  bool get isLoading => _isLoading;
  String get chatId => _chatId;
  TextEditingController get msgController => _msgController;
  List<dynamic> get allMessagesList => _allMessagesList;
  List<dynamic> get conversationList => _conversationList;
  String get userId => _userId;
  String get usersAuth => _usersAuth;
  String get fileName => _fileName;
  String get fileUrl => _fileUrl;
  File? get selectedImage => _selectedImage;
  String get imageUrl => _imageUrl;
  String get readID => _readID;
  bool get online => _online;
  String get lastSeen => _lastSeen;
  bool get isEmojiVisible => _isEmojiVisisble;
  FocusNode get focusNode => _focusNode;
  Widget get thumbNail => _thumbNail;

  // SETTERS
  updateIsLoading(value) {
    _isLoading = value;
    update();
  }
  updateChatId(value) {
    _chatId = value;
    update();
  }
  addToMessages(value) {
    _allMessagesList.insert(0, value);
    update();
  }
  updateAllMessagesList(value) {
    _allMessagesList = value;
    update();
  }
  updateConversationList(value) {
    _conversationList = value;
    update();
  }
  changeConversationList(value) {
    _conversationList = value;
    update();
  }
  void updateLastMessageTime(Map<String, dynamic> userChat) {
    for (var user in _conversationList) {
      if (user["chat"] == userChat) {
        _conversationList.remove(user["chat"]);
        _conversationList.insert(0, user["chat"]);
        break;
      }
    }

    update();
  }
  updateMessageText(value) {
    _messageText = value;
    update();
  }
  updateUserId(value) {
    _userId = value;
    update();
  }
  getUsersAuth() async{
    _usersAuth = await LocalStorage().fetchUserAUTH();
    update();
  }
  updateFileName(value) {
    _fileName = value;
    update();
  }
  updateFileUrl(value) {
    _fileUrl = value;
    update();
  }
  updateSelectedImage(value) {
    _selectedImage = value;
    update();
  }
  updateImageUrl(value) {
    _imageUrl = value;
    update();
  }
  updateUserAuth() async{
    _usersAuth = await LocalStorage().fetchUserAUTH();
    _userId = await LocalStorage().fetchUserId();
    update();
  }
  updateReadID(value) {
    _readID = value;
    null;
    update();
  }  
  updateOnlineStatus(value) {
    _online = value;
    update();
  }  
  updateLastSeen(String value) {
    _lastSeen = value.split(" ").first;
    update();
  }
  toggleEmojiPicker() {
    _isEmojiVisisble = !_isEmojiVisisble;
    update();
  }
  updateThumbNail(value) {
    _thumbNail = value;
    update();
  }

  // GET FILE
  Future<void> getFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);
        final thumbnail = await FilePreview.getThumbnail(file.path);
        print(file);
        updateFileName(file.path.split("/").last);
        updateThumbNail(thumbnail);

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
  Future<void> getImageUrl(ImageSource imageSource, chatID) async {
    try {
      var _pickedImage = await _imagePicker.pickImage(
        source: imageSource,
      );
      if (_pickedImage != null) {
        updateSelectedImage(File(_pickedImage.path));

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

        if(_imageUrl != ""){
          print("IMAGE URL::::::$_imageUrl");
          sendMessage("image", _imageUrl, chatID);
        }else{
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

  // CALCULATE TIME STAMP
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

  // MESSAGE SENT TIME
  String getTimeOfDay(String timestamp) {
    DateTime date = DateTime.parse(timestamp);

    // Get the hours and minutes from the date
    int hours = date.hour;
    int minutes = date.minute;

    // Format the time of the day
    String timeOfDay = '$hours:$minutes';

    return timeOfDay;
  }

  // CREATE CONVERSATION
  Future<void> createConversation(String recevierId, firstname, lastname, profileImage) async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "recevier": recevierId
    };
    print(details);

    var response = await ChatApiServices.createConversationService(details);
    var responseData = await response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess) {
      updateIsLoading(false);

      updateChatId(responseData["data"]["_id"]);

      Get.toNamed(
        chatRoom,
        arguments: {
          "chatId": _chatId,
          "senderAuth": await LocalStorage().fetchUserAUTH(),
          "userFirstName": firstname,
          "userLastName": lastname,
          "userProfileImage": profileImage,
        }
      );

      String id = await LocalStorage().fetchUserId();
      updateUserId(id);

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

  // GET CONVERSATIONS
  Future<void> getConversations() async{
    updateIsLoading(true);

    var response = await ChatApiServices.getConversationService();
    var responseData = await response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess) {
      updateIsLoading(false);

      // updateChatId(responseData["data"]);

      updateConversationList(responseData["data"]);
      
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

  // LOAD ALL MESSAGES IN CHAT ROOM
  Future<void> loadAllMessages(String chatID) async{
    // updateIsLoading(true);

    var response = await ChatApiServices.loadAllMessageService(chatID);
    var responseData = await response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess) {
      updateIsLoading(false);

      updateAllMessagesList(responseData["data"]);

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

  // SEND MESSAGE
  Future<void> sendMessage(String type, String message, String chatID) async{
    updateIsLoading(true);

    Map<String, dynamic> details = {
      "type": type,
      "body": message
    };
    print(details);
    print(chatId);

    var response = await ChatApiServices.sendMessageService(details, chatID);
    var responseData = await response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess) {
      updateIsLoading(false);

      // addToMessages(responseData["newMessage"]);

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

  // MARK AS READ
  Future<void> markMessageRead(String chatID, userID) async{

    var response = await ChatApiServices.markMessageAsReadService(chatID, userID);
    var responseData = await response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess) {

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
  
  // ONLINE STATUS
  Future<void> checkOnlineStatus(String id) async{

    var response = await ChatApiServices.onlineStatusService(id);
    var responseData = await response!.data;
    print(responseData);

    bool isSuccess = responseData["success"];
    if(isSuccess) {

      updateOnlineStatus(responseData["data"]["online"]);
      updateLastSeen(responseData["data"]["lastSeen"]);

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

    update();
  }

}