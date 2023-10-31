import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage{

  final FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

  // STORE ID
  storeUserId(String userId) async{
    try {
      await _flutterSecureStorage.write(key: "UserId", value: userId);
      print("Saved Id");
    } catch (e) {
      print(e);
      print("Could not save id");
    }
  }

  // FETCH ID
  Future<String> fetchUserId() async{
    String userId = await _flutterSecureStorage.read(key: "UserId") ?? "";
    print("Fetched Id successful");

    return userId;
  }

  // STORE TOKEN
  storeUserToken(String token) async{
    try {
      await _flutterSecureStorage.write(key: "Token", value: token);
      await _flutterSecureStorage.write(key: "TOKEN", value: token);
      print("Saved Token");
    } catch (e) {
      print(e);
      print("Could not save token");
    }
  }

  // STORE TOKEN
  storeUserToken2(String token) async{
    try {
      await _flutterSecureStorage.write(key: "TOKEN", value: token);
      print("Saved Token2");
    } catch (e) {
      print(e);
      print("Could not save token2");
    }
  }

  // FETCH TOKEN
  Future<String> fetchUserToken() async{
    String token = await _flutterSecureStorage.read(key: "Token") ?? "";
    print("Fetched token successful");

    return token;
  }

  // FETCH TOKEN2
  Future<String> fetchUserToken2() async{
    String token = await _flutterSecureStorage.read(key: "TOKEN") ?? "";
    print("Fetched token2 successful");

    return token;
  }

  // STORE TOKEN
  storeUserAUTH(String auth) async{
    try {
      await _flutterSecureStorage.write(key: "AUTH", value: auth);
      print("Saved Auth");
    } catch (e) {
      print(e);
      print("Could not save Auth");
    }
  }

  // FETCH TOKEN
  Future<String> fetchUserAUTH() async{
    String auth = await _flutterSecureStorage.read(key: "AUTH") ?? "";
    print("Fetched auth successful");

    return auth;
  }

  // STORE DEVICE ID
  storeDeviceId(String deviceID) async{
    try {
      await _flutterSecureStorage.write(key: "DeviceID", value: deviceID);
      print("Saved Id");
    } catch (e) {
      print(e);
      print("Could not save id");
    }
  }

  // FETCH DEVICE ID
  Future<String> fetchDeviceID() async{
    String deviceID = await _flutterSecureStorage.read(key: "DeviceID") ?? "";
    print("Fetched Id successful");

    return deviceID;
  }

  // STORE EMAIL
  storeEmail(String email) async{
    try {
      await _flutterSecureStorage.write(key: "Email", value: email);
      print("Saved Email");
    } catch (e) {
      print(e);
      print("Could not save EMail");
    }
  }

  // FETCH EMAIL
  Future<String> fetchEmail() async{
    String email = await _flutterSecureStorage.read(key: "Email") ?? "";
    print("Fetched email successful");

    return email;
  }

  // STORE TYPE
  storeType(String type) async{
    try {
      await _flutterSecureStorage.write(key: "Type", value: type);
      print("Saved TYPE");
    } catch (e) {
      print(e);
      print("Could not save TYPE");
    }
  }

  // FETCH TYPE
  Future<String> fetchType() async{
    String type = await _flutterSecureStorage.read(key: "Type") ?? "";
    print("Fetched type successful");

    return type;
  }

  // DELETE USER FROM STORAGE
  Future<void> deleteUserStorage() async{
    await _flutterSecureStorage.deleteAll();
    print("Deleted Storage :)");
  }
}