import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import '../../routes/app_route_names.dart';


class JobApplicationBottomSheet {
  static showJobApplicationBottomSheet (String url, fileName, id, auth, name, coverLetter) {

    downloadFile() async {
      final status = await Permission.storage.request();

      if (status.isDenied){
        Fluttertoast.showToast(
          msg: "Permission denied",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
        );

      } else {

        final externalDir = await getExternalStorageDirectory();

        final taskID = await FlutterDownloader.enqueue(
          url: url, 
          savedDir: externalDir!.path,
          fileName: fileName,
          showNotification: true,
          openFileFromNotification: true,
        );
      }    
    }
    Get.bottomSheet(
      Container(
        height: 400,
        width: Get.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white
        ),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: const Color(0xffE7E7E7),
                borderRadius: BorderRadius.circular(10)
              ),
            ),
            const SizedBox(height: 20,),
            const Row(
              children:  [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Job Appication",
                    style: TextStyle(
                      color: Color(0xff03132B),
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            ListTile(
              onTap: () async{
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
                  // Make a GET request to the URL
                // final response = await http.get(Uri.parse(url));

                // // Check if the request was successful
                // if (response.statusCode == 200) {
                //   // Get the app's documents directory
                //   final appDocDir = await getApplicationDocumentsDirectory();

                //   // Create a File object to save the downloaded file
                //   final file = File('${appDocDir.path}/$fileName');

                //   // Write the downloaded bytes to the file
                //   await file.writeAsBytes(response.bodyBytes);

                //   print('File downloaded to: ${file.path}');
                // } else {
                //   print('Error downloading file: ${response.reasonPhrase}');
                // }
              },
              title: Text(
                "Download $name Resume",
                style: const TextStyle(
                  color: Color(0xff0E0E0E),
                  fontSize: 16,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Color(0xffE7E7E7),
              ),
            ),
            ListTile(
              onTap: () {
                print(coverLetter);
                Get.toNamed(
                  coverLetterScreen,
                  arguments: {
                    "cover_letter": coverLetter
                  }
                );
              },
              title: const Text(
                "View Cover Letter",
                style: TextStyle(
                  color: Color(0xff0E0E0E),
                  fontSize: 16,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Color(0xffE7E7E7),
              ),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(
                    firmSendInterviewInvite,
                  arguments: {
                      "id": id,
                    "auth": auth
                  }
                );
              },
              title: const Text(
                "Send Interview Invitation",
                style: TextStyle(
                  color: Color(0xff0E0E0E),
                  fontSize: 16,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}