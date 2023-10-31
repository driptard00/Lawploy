import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class PdfViewerScreen extends StatelessWidget {
   PdfViewerScreen({super.key});

  final file = Get.arguments["file"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "File Viewer",
          style: TextStyle(
              color: Color(0xff03132B),
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              FileDownloader.downloadFile(
                url: file,
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
            child: Icon(
              Iconsax.document_download,
              color: Color(0xff03132B),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: PDF(
        swipeHorizontal: true,
      ).cachedFromUrl(file,
        placeholder: (progress) => Center(child: Text('$progress %')),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),

    );
  }
}