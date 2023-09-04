import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lawploy_app/routes/app_route_names.dart';
import 'package:lawploy_app/routes/app_routes.dart';
import 'package:lawploy_app/services/firebase/firebase_api_service.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{  

  WidgetsFlutterBinding.ensureInitialized();
   
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApiService().initNotifications(); 

  await dotenv.load(fileName: ".env");

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
      initialRoute: splashScreen,
      getPages: getPages,
    );
  }
} 


    