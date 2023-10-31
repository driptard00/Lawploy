import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/briefStateController.dart';
import 'package:lawploy_app/controllers/chat_controller.dart';
import 'package:loading_overlay/loading_overlay.dart';



class LawyerBriefDescriptionScreen extends StatefulWidget {
  LawyerBriefDescriptionScreen({super.key});

    @override
  State<LawyerBriefDescriptionScreen> createState() => _LawyerBriefDescriptionScreenState();
}

class _LawyerBriefDescriptionScreenState extends State<LawyerBriefDescriptionScreen> {

  final image = Get.arguments["image"];
  final name = Get.arguments["name"];
  final description = Get.arguments["description"];
  final url = Get.arguments["url"];
  final fileName = Get.arguments["fileName"];
  final id = Get.arguments["ID"];
  final date = Get.arguments["date"];
  final time = Get.arguments["time"];

  final BriefStateController _briefStateController = Get.find<BriefStateController>();
  final ChatController _chatController = Get.put(ChatController());
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    print(url);
    print(fileName);
    return GetBuilder<BriefStateController>(
      builder: (controller) {
        return LoadingOverlay(
          isLoading: controller.isLoading,
          color: Colors.black,
          progressIndicator: CircularProgressIndicator(
            color: Color(0xff041C40),
          ),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xffF9F9F9),
              elevation: 1,
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Iconsax.arrow_left,
                  color: Color(0xff041C40),
                ),
              ),
              title: const Text(
                "Briefs",
                style: TextStyle(
                    color: Color(0xff03132B),
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              centerTitle: true,
            ),
            body: Container(
              height: Get.height,
              width: Get.width,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 8,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                           ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: (image != null)?
                              NetworkImage(
                                image
                              )
                              :
                              const AssetImage(
                                "images/profileAvatar.png"
                              ) as ImageProvider
                            ),
                            title: Text(
                              name,
                              style:  const TextStyle(
                                  color: Color(0xff0E0E0E),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                             subtitle: Row(
                               children: [
                                  Text(
                                   date,
                                   style: TextStyle(
                                     fontSize: 12,
                                     color: Color(0xff5E5E5E),
                                   ),
                                 ),
                                 const SizedBox(
                                   width: 10,
                                 ),
                                 Container(
                                   height: 5,
                                   width: 5,
                                   decoration: BoxDecoration(
                                       color: const Color(0xffD3A518),
                                       borderRadius: BorderRadius.circular(5)
                                   ),
                                 ),
                                 const SizedBox(
                                   width: 10,
                                 ),
                                 Text(
                                   time,
                                   style: const TextStyle(
                                     fontSize: 12,
                                     color: Color(0xff5E5E5E),
                                   ),
                                 ),
                               ],
                             ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              color: Color(0xffD3D3D3),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                const Text(
                                  "Brief",
                                  style: TextStyle(
                                      color: Color(0xff0E0E0E),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Text(
                                  (description == null)?
                                    "Nil"
                                  :
                                  description,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      color: Color(0xff5E5E5E),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      color: const Color(0xffF9F9F9),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: Get.width,
                            child: TextButton(
                              onPressed: () async {
                                FileDownloader.downloadFile(
                                  url: url,
                                  onProgress: (name, progress) {
                                    Fluttertoast.showToast(
                                      msg: "Downloading file $progress",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  },
                                  onDownloadCompleted: (value) {
                                    print('path  $value ');
                                    Fluttertoast.showToast(
                                      msg: "File downloaded in $value",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  },
                                  onDownloadError: (value) {
                                    Fluttertoast.showToast(
                                      msg: "Download Failed!",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  }
                                );
                              },
        
                              style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xff041C40),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                              ),
                              child: const Text(
                                "Download Brief",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 50,
                            width: Get.width,
                            child: TextButton(
                              onPressed: () {
                                _chatController.createConversation(id, name, "", image, id);
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(0),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  side: const BorderSide(
                                      color: Color(0xff041C40)
                                  )
                              ),
                              child: Text(
                                "Message $name",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Color(0xff041C40),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}