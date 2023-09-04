import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/chat_controller.dart';
import 'package:lawploy_app/routes/app_route_names.dart';
import 'package:lawploy_app/storage/secureStorage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreenView extends StatefulWidget {
  ChatScreenView({super.key});

  @override
  _ChatScreenViewState createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {

  final ChatController _chatController = Get.put(ChatController());

  late IO.Socket _socket;
  String? _userAuth;

  void _connectToSocket() async {
    _userAuth = await LocalStorage().fetchUserAUTH();
    print("AUTHHHHHH:::$_userAuth");
    _socket = IO.io(
        "https://lawploy.onrender.com?auth=$_userAuth",
        IO.OptionBuilder().setTransports(['websocket'])
        .enableReconnection()
        .enableForceNewConnection()
        .enableAutoConnect()
        .build()
    );

    // _socket.on('chat', (data) {
    //   // Handle the received event data
    //   print('Received event: $data');
    //   _chatController.updateLastMessageTime(data["chat"]);
    // });

    _socket.on('error', (data) {
      print('Socket error: $data');
    });

    _socket.on('disconnect', (data) {
      print('Socket disconnected: $data');
    });

    _socket.on('connect', (data) {
      print('Socket Connected!!!!: $data');
    });

    _socket.connect();

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _chatController.updateUserAuth();
    _connectToSocket();
    _chatController.getConversations();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ChatController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                Expanded(
                  child: (controller.isLoading)?
                  const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff03132B),
                    )
                  )
                  :
                  (controller.conversationList.isEmpty)?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("images/noMessages.png"),
                      const SizedBox(height: 10,),
                      const Text(
                        "No messages!"
                      )
                    ],
                  )
                  :
                  ListView.separated(
                    itemCount: controller.conversationList.length,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Color(0xffCFCFCF),
                      );
                    },
                    itemBuilder: (context, index) {
                      return (controller.conversationList[index]["lastMessage"] == null && controller.conversationList.length == 1)?
                      null
                      :
                      InkWell(
                        onTap: () {
                          Get.toNamed(
                            chatRoom,
                            arguments: {
                              "chatId": controller.conversationList[index]["_id"],
                              "userFirstName": controller.conversationList[index]["user"]["first_name"],
                              "userLastName": controller.conversationList[index]["user"]["last_name"],
                              "userID": controller.conversationList[index]["user"]["_id"],
                              "userProfileImage": controller.conversationList[index]["user"]["profile_image"],
                              "senderAuth": controller.usersAuth,
                            }
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: (controller.conversationList[index]["user"]["profile_image"] == null)?
                                  const AssetImage("images/profileAvatar.png") as ImageProvider
                                  :
                                  NetworkImage(controller.conversationList[index]["user"]["profile_image"]),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Expanded(
                                flex: 8,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:  [
                                        (controller.conversationList[index]["type"] == "lawyer")?
                                        Text(
                                          "${controller.conversationList[index]["user"]["first_name"]} ${controller.conversationList[index]["user"]["last_name"]}",
                                          style: const TextStyle(
                                            color:Color(0xff0E0E0E),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700
                                          ),
                                        )
                                        :
                                        Text(
                                          controller.conversationList[index]["user"]["name"],
                                          style: const TextStyle(
                                            color:Color(0xff0E0E0E),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700
                                          ),
                                        ),
                                        Text(
                                          controller.calculateTimeDifference(controller.conversationList[index]["lastUpdate"]),
                                          style: const TextStyle(
                                            color:Color(0xff5E5E5E),
                                            fontSize: 12
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: (controller.conversationList[index]["lastMessage"]["_type"] == "text")?
                                          Text(
                                            controller.conversationList[index]["lastMessage"]["body"],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color:Color(0xff5E5E5E),
                                              fontSize: 12,
                                            ),
                                          )
                                          :
                                          (controller.conversationList[index]["lastMessage"]["_type"] == "image")?
                                          Row(
                                            children: const[
                                              Icon(
                                                Iconsax.gallery,
                                                color:Color(0xff5E5E5E),
                                                size: 12
                                              ),
                                               SizedBox(
                                                width: 5
                                              ),
                                              Text(
                                                "Image",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color:Color(0xff5E5E5E),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          )
                                          :
                                          (controller.conversationList[index]["lastMessage"]["_type"] == "video")?
                                          Row(
                                            children: const[
                                              Icon(
                                                Iconsax.video,
                                                color:Color(0xff5E5E5E),
                                                size: 12
                                              ),
                                               SizedBox(
                                                width: 5
                                              ),
                                              Text(
                                                "Video",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color:Color(0xff5E5E5E),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          )
                                          :
                                          (controller.conversationList[index]["lastMessage"]["_type"] == "file")?
                                          Row(
                                            children: const[
                                              Icon(
                                                Iconsax.document,
                                                color:Color(0xff5E5E5E),
                                                size: 12
                                              ),
                                               SizedBox(
                                                width: 5
                                              ),
                                              Text(
                                                "File",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color:Color(0xff5E5E5E),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          )
                                          :
                                          (controller.conversationList[index]["lastMessage"]["_type"] == "audio")?
                                          const Row(
                                            children: const[
                                              Icon(
                                                Iconsax.music,
                                                color:Color(0xff5E5E5E),
                                                size: 12
                                              ),
                                               SizedBox(
                                                width: 5
                                              ),
                                              Text(
                                                "Audio",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color:Color(0xff5E5E5E),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          )
                                          :
                                          const Text(
                                            ""
                                          )
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: (controller.conversationList[index]["unread"] == 0)?
                                              null
                                              :
                                            Container(
                                              height: 18,
                                              width: 18,
                                              decoration: BoxDecoration(
                                                color: const Color(0xffD3A518),
                                                borderRadius: BorderRadius.circular(20)
                                              ),
                                              alignment: Alignment.center,
                                              child: 
                                              Text(
                                                controller.conversationList[index]["unread"].toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}