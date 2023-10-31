import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/appStateController.dart';
import 'package:lawploy_app/controllers/privateStateController.dart';
import 'package:lawploy_app/storage/secureStorage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../controllers/chat_controller.dart';

class PIHolderScreen extends StatefulWidget {
  PIHolderScreen({super.key});
  

    @override
  _PIHolderScreenState createState() => _PIHolderScreenState();
}

class _PIHolderScreenState extends State<PIHolderScreen> {
  
  final AppStateController _appStateController = Get.put(AppStateController());
  final PrivateStateController _privateStateController = Get.put(PrivateStateController());
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
    _privateStateController.getPrivateDetails();
    _privateStateController.getAllLawyers();
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
    //   _privateStateController.getPrivateDetails();
    //   _privateStateController.getAllLawyers();
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
          controller.piScreens[controller.selectedPIScreenIndex],
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
                        controller.updateselectedPIScreenIndex(0);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedPIScreenIndex == 0)?
                            Iconsax.home5
                            :
                            Iconsax.home,
                            color: (controller.selectedPIScreenIndex == 0)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Home",
                            style: TextStyle(
                              color: (controller.selectedPIScreenIndex == 0)?
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
                        controller.updateselectedPIScreenIndex(1);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedPIScreenIndex == 1)?
                            Iconsax.layer5
                            :
                            Iconsax.layer,
                            color: (controller.selectedPIScreenIndex == 1)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Jobs",
                            style: TextStyle(
                              color: (controller.selectedPIScreenIndex == 1)?
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
                        controller.updateselectedPIScreenIndex(2);
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
                             (controller.selectedPIScreenIndex == 2)?
                              Iconsax.message5
                              :
                              Iconsax.message,
                              color: (controller.selectedPIScreenIndex == 2)?
                              const Color(0xffD3A518)
                              :
                              const Color(0xffAFAFAF),
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Message",
                            style: TextStyle(
                              color: (controller.selectedPIScreenIndex == 2)?
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
                        controller.updateselectedPIScreenIndex(3);
                      },
                      child: Column(
                        children: [
                          Icon(
                            (controller.selectedPIScreenIndex == 3)?
                            Iconsax.profile_circle5
                            :
                            Iconsax.profile_circle,
                            color: (controller.selectedPIScreenIndex == 3)?
                            const Color(0xffD3A518)
                            :
                            const Color(0xffAFAFAF),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Profile",
                            style: TextStyle(
                              color: (controller.selectedPIScreenIndex == 3)?
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