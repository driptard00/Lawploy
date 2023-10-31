import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lawploy_app/controllers/appStateController.dart';
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
  final AppStateController _appStateController = Get.put(AppStateController());

  late IO.Socket _socket;
  String? _userAuth;

  void getAuth() async {
    _userAuth = await LocalStorage().fetchUserAUTH();
    setState(() {
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _chatController.updateUserAuth();
    getAuth();
    _appStateController.getConversations();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('USSEEEEEEERRRRRRRAURHTTHTHTH:$_userAuth');
    return GetBuilder<AppStateController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                Expanded(
                  child: 
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
                        onTap: () async {
                          String auth = await LocalStorage().fetchUserAUTH();

                          Get.toNamed(
                            chatRoom,
                            arguments: {
                              "chatId": controller.conversationList[index]["_id"],
                              "name": (controller.conversationList[index]["type"] == "lawyer" || controller.conversationList[index]["type"] == "private")?
                              "${controller.conversationList[index]["user"]["first_name"]} ${controller.conversationList[index]["user"]["last_name"]}"
                              :
                              controller.conversationList[index]["user"]["name"],
                              "userID": controller.conversationList[index]["user"]["_auth"],
                              "userProfileImage": controller.conversationList[index]["user"]["profile_image"],
                              // "senderAuth": controller.usersAuth,
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
                                          (controller.conversationList[index]["type"] == "lawyer" || controller.conversationList[index]["type"] == "private")?
                                          "${controller.conversationList[index]["user"]["first_name"]} ${controller.conversationList[index]["user"]["last_name"]}"
                                          :
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
                                          child: (controller.conversationList[index]["lastMessage"] == null)?
                                          const Text(
                                            "No messages, click to chat",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color:Color(0xff5E5E5E),
                                              fontSize: 12,
                                            ),
                                          )
                                          :
                                          (controller.conversationList[index]["lastMessage"]["_type"] == "text")?
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
                                          const Row(
                                            children: [
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
                                          const Row(
                                            children: [
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
                                          const Row(
                                            children: [
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
                                            children: [
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
                                            child: (controller.conversationList[index]["lastMessage"] != null)?
                                            (controller.conversationList[index]["lastMessage"]["_sender"] != _userAuth && !controller.conversationList[index]["lastMessage"]["read"])?
                                            Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                color: const Color(0xffD3A518),
                                                borderRadius: BorderRadius.circular(20)
                                              ),
                                              alignment: Alignment.center,
                                            )
                                            :
                                              null
                                            :
                                            null
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