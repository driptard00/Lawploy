import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/appStateController.dart';
import 'package:lawploy_app/controllers/chat_controller.dart';
import 'package:lawploy_app/controllers/lawyerStateController.dart';
import 'package:lawploy_app/storage/secureStorage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LawyerHolderScreen extends StatefulWidget {
  LawyerHolderScreen({super.key});

      @override
  LawyerHolderScreenState createState() => LawyerHolderScreenState();
}

class LawyerHolderScreenState extends State<LawyerHolderScreen> {
  
  final AppStateController _appStateController = Get.put(AppStateController());
  final LawyerStateController _lawyerStateController = Get.put(LawyerStateController());
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
        _appStateController.getConversations();
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
    _lawyerStateController.getLawyerDetails();
    _lawyerStateController.getAllLawyers();
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
    //   _lawyerStateController.getLawyerDetails();
    //   _lawyerStateController.getAllLawyers();
    //   _lawyerStateController.getAllActiveJobs();
    //   _appStateController.getConversations();
    //   _appStateController.getAllRecievedInterviews();
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
          controller.lawyerScreens[controller.selectedLawyerScreenIndex],
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
                        controller.updateselectedLawyerScreenIndex(0);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedLawyerScreenIndex == 0)?
                            Iconsax.home5
                            :
                            Iconsax.home,
                            color: (controller.selectedLawyerScreenIndex == 0)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Home",
                            style: TextStyle(
                              color: (controller.selectedLawyerScreenIndex == 0)?
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
                        controller.updateselectedLawyerScreenIndex(1);
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
                              (controller.selectedLawyerScreenIndex == 1)?
                              Iconsax.receipt_text5
                              :
                              Iconsax.receipt_text,
                              color: (controller.selectedLawyerScreenIndex == 1)?
                              const Color(0xffD3A518)
                              :
                              const Color(0xffAFAFAF),
                            ),
                            
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Briefs",
                            style: TextStyle(
                              color: (controller.selectedLawyerScreenIndex == 1)?
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
                        controller.updateselectedLawyerScreenIndex(2);
                      },
                      child: Column(
                        children: [
                          Badge(
                            isLabelVisible: (controller.acceptedList.isEmpty)?
                            false:
                            true,
                            label: Text(
                              (controller.acceptedList.length > 9)?
                              "9+"
                              :
                              controller.acceptedList.length.toString(),
                              style: const TextStyle(
                                color: Colors.white
                              ),
                            ),
                            child: Icon(
                              (controller.selectedLawyerScreenIndex == 2)?
                              Iconsax.layer5
                              :
                              Iconsax.layer,
                              color: (controller.selectedLawyerScreenIndex == 2)?
                              const Color(0xffD3A518)
                              :
                              const Color(0xffAFAFAF),
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Jobs",
                            style: TextStyle(
                              color: (controller.selectedLawyerScreenIndex == 2)?
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
                        controller.updateselectedLawyerScreenIndex(3);
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
                             (controller.selectedLawyerScreenIndex == 3)?
                              Iconsax.message5
                              :
                              Iconsax.message,
                              color: (controller.selectedLawyerScreenIndex == 3)?
                              const Color(0xffD3A518)
                              :
                              const Color(0xffAFAFAF),
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Message",
                            style: TextStyle(
                              color: (controller.selectedLawyerScreenIndex == 3)?
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
                        controller.updateselectedLawyerScreenIndex(4);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedLawyerScreenIndex == 4)?
                            Iconsax.profile_circle5
                            :
                            Iconsax.profile_circle,
                            color: (controller.selectedLawyerScreenIndex == 4)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Profile",
                            style: TextStyle(
                              color: (controller.selectedLawyerScreenIndex == 4)?
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