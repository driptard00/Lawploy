import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/appStateController.dart';
import 'package:lawploy_app/controllers/lawfirmStateController.dart';
import 'package:lawploy_app/storage/secureStorage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../controllers/chat_controller.dart';


class LawFirmHolderScreen extends StatefulWidget {
  LawFirmHolderScreen({super.key});
 
    @override
  _LawFirmHolderScreenState createState() => _LawFirmHolderScreenState();
}

class _LawFirmHolderScreenState extends State<LawFirmHolderScreen> {
  
  final LawFirmStateController _lawFirmStateController = Get.put(LawFirmStateController());
  final AppStateController _appStateController = Get.put(AppStateController());
  final ChatController _chatController = Get.put(ChatController());

  late IO.Socket _socket;
  String? _userAuth;

  void _connectToSocket() async {
    try {
      _userAuth = await LocalStorage().fetchUserAUTH();
      print("AUTHHHHHH: $_userAuth");

      _socket = IO.io(
        "http://api.lawploy.com:3000",
        <String, dynamic>{
          'transports': ['websocket'],
          'query': 'auth=$_userAuth',
        },
      );

      _socket.onConnect((_) {
        print('Socket Connected!!!!');
      });

      _socket.on('chat', (data) {
        print('Received chat event: $data');
        _chatController.getConversations();
      });

      _socket.on('message', (data) {
        _chatController.addToMessages(data);
        print('Received message event: $data');
      });

      _socket.on('error', (error) {
        print('Socket error: $error');
      });

      _socket.onDisconnect((_) {
        print('Socket disconnected');
      });

      _socket.on('echo', (data) {
        print('Received echo event: $data');
        // Handle the received echo data
      });

      // Connect to the socket.
      _socket.connect();

      setState(() {
        // Update the UI if needed.
      });
    } catch (e) {
      print('Error connecting to the socket: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _connectToSocket();
    _lawFirmStateController.getLawFirmProfile();
    _lawFirmStateController.getAllLawyers();
    _appStateController.getAllNotifications();
    _appStateController.getAllJobData();
    _appStateController.getAllSentInterviews();
    _appStateController.getConversations();
    _appStateController.getAllRecievedInterviews();
    _appStateController.getMyBriefs();
    super.initState();
  }

  @override
  void dispose() {
    _socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _lawFirmStateController.getLawFirmProfile();
    //   _lawFirmStateController.getAllLawyers();
    //   _appStateController.getConversations();
    // },);
    
    return GetBuilder<AppStateController>(
      builder: (controller) {
        return Scaffold(
          body: (controller.isLoading)?
          const Center(
            child: CircularProgressIndicator(
              color: Color(0xff041C40),
            ),
          )
          :
          controller.lawFirmsScreens[controller.selectedLawFirmScreenIndex],
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 70,
              width: Get.width,
              color: Colors.white,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        controller.updateselectedLawFirmScreenIndex(0);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedLawFirmScreenIndex == 0)?
                            Iconsax.home5
                            :
                            Iconsax.home,
                            color: (controller.selectedLawFirmScreenIndex == 0)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Home",
                            style: TextStyle(
                              color: (controller.selectedLawFirmScreenIndex == 0)?
                              const Color(0xff041C40)
                              :
                              const Color(0xffAFAFAF),
                            ),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.updateselectedLawFirmScreenIndex(1);
                      },
                      child: Column(
                        children: [
                          Badge(
                            isLabelVisible: (controller.myBriefList.isEmpty)?
                            false:
                            true,
                            label: Text(
                              (controller.myBriefList.length > 9)?
                              "9+"
                              :
                              controller.myBriefList.length.toString(),
                              style: const TextStyle(
                                color: Colors.white
                              ),
                            ),
                            child: Icon(
                              (controller.selectedLawFirmScreenIndex == 1)?
                              Iconsax.receipt_text5
                              :
                              Iconsax.receipt_text,
                              color: (controller.selectedLawFirmScreenIndex == 1)?
                              const Color(0xffD3A518)
                              :
                              const Color(0xffAFAFAF),
                            ),
                            
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Briefs",
                            style: TextStyle(
                              color: (controller.selectedLawFirmScreenIndex == 1)?
                              const Color(0xff041C40)
                              :
                              const Color(0xffAFAFAF),
                            ),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.updateselectedLawFirmScreenIndex(2);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedLawFirmScreenIndex == 2)?
                            Iconsax.layer5
                            :
                            Iconsax.layer,
                            color: (controller.selectedLawFirmScreenIndex == 2)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Jobs",
                            style: TextStyle(
                              color: (controller.selectedLawFirmScreenIndex == 2)?
                              const Color(0xffD3A518)
                              :
                              const Color(0xffAFAFAF),
                            ),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.updateselectedLawFirmScreenIndex(3);
                      },
                      child: Column(
                        children: [
                          Badge(
                            isLabelVisible: (controller.readList.isEmpty)?
                            false
                            :
                            true,
                            label: Text(
                              (controller.readList.length > 9)?
                              "9+"
                              :
                              controller.readList.length.toString(),
                              style: const TextStyle(
                                color: Colors.white
                              ),
                            ),
                            child: Icon(
                             (controller.selectedLawFirmScreenIndex == 3)?
                              Iconsax.message5
                              :
                              Iconsax.message,
                              color: (controller.selectedLawFirmScreenIndex == 3)?
                              const Color(0xffD3A518)
                              :
                              const Color(0xffAFAFAF),
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Message",
                            style: TextStyle(
                              color: (controller.selectedLawFirmScreenIndex == 3)?
                              const Color(0xff041C40)
                              :
                              const Color(0xffAFAFAF),
                            ),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.updateselectedLawFirmScreenIndex(4);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedLawFirmScreenIndex == 4)?
                            Iconsax.profile_circle5
                            :
                            Iconsax.profile_circle,
                            color: (controller.selectedLawFirmScreenIndex == 4)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Profile",
                            style: TextStyle(
                              color: (controller.selectedLawFirmScreenIndex == 4)?
                              const Color(0xff041C40)
                              :
                              const Color(0xffAFAFAF),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}