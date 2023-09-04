import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import '../../controllers/briefStateController.dart';

class MyBriefsBottomSheet {
  static showMyBriefsBottomSheet (String name, url, fileName) {
    Get.bottomSheet(
      GetBuilder<BriefStateController>(
        builder: (controller) {
          return Container(
            height: 280,
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
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "My Briefs",
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
                  onTap: () {
                    FileDownloader.downloadFile(
                      url: url,
                      name: fileName,
                      onProgress: (fileName, double progress) {
                        print('FILE fileName HAS PROGRESS $progress');
                        Fluttertoast.showToast(
                            msg: "File Downloading...",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      },
                      onDownloadCompleted: (String path) {
                        Fluttertoast.showToast(
                            msg: "File Downloaded Check Files",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      },
                    );
                    // controller.openBrief(fileUrl: url, fileName: fileName);
                  },
                  title: const Text(
                    "Download Brief",
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
                    
                  },
                  title: Text(
                    "Message $name",
                    style: const TextStyle(
                      color: Color(0xff0E0E0E),
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      )
    );
  }
}