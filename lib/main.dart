import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:lawploy_app/controllers/appStateController.dart';
import 'package:lawploy_app/routes/app_route_names.dart';
import 'package:lawploy_app/routes/app_routes.dart';
import 'package:lawploy_app/services/firebase/firebase_api_service.dart';
import 'package:lawploy_app/storage/secureStorage.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

String? initialRoute;
String? token;
String? userType;

final AppStateController _appStateController = Get.put(AppStateController());

void main() async{  

  WidgetsFlutterBinding.ensureInitialized();
   
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  _appStateController.pingServer();

  await FirebaseApiService().initNotifications(); 

  await dotenv.load(fileName: ".env");


   // Plugin must be initialized before using
  await FlutterDownloader.initialize(
    debug: true,
    ignoreSsl: true
  );



  token = await LocalStorage().fetchUserToken2();
  userType = await LocalStorage().fetchType();

  (token == "")?
  initialRoute = onboardingScreen
  :
  initialRoute = (userType == "lawyer")?
  lawyerHolderScreen
  :
  (userType == "private")?
  piHolderScreen
  :
  (userType == "firm")?
  lawFirmHolderScreen
  :
  (userType == "corporation")?
  companyHolderScreen
  :
  null;


  runApp(const MyApp());
  
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lawploy',
      theme: ThemeData(
        fontFamily: "Cabinet"
      ),
      initialRoute: initialRoute,
      getPages: getPages,
    );
  }
} 


    