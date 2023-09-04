import 'package:audioplayers/audioplayers.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lawploy_app/controllers/chat_controller.dart';
import 'package:lawploy_app/storage/secureStorage.dart';
import 'package:record/record.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../Widget/BottomSheets/chatting_bottom_sheet_image.dart';
import 'package:flutter/foundation.dart' as foundation;


class ChatRoom extends StatefulWidget {
  ChatRoom({super.key});

    @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  final chatID = Get.arguments["chatId"];
  final senderAuth = Get.arguments["senderAuth"];
  final userFirstName = Get.arguments["userFirstName"];
  final userLastName = Get.arguments["userLastName"];
  final userID = Get.arguments["userID"];
  final userProfileImage = Get.arguments["userProfileImage"];

  final ChatController _chatController = Get.find<ChatController>();
  late IO.Socket _socket;
  late Record audioRecord;
  late AudioPlayer audioPlayer;
  bool isRecording = false;
  bool startPlayer = false;
  bool isPlaying = false; 
  String audioPath = "";
  final cloudinary = Cloudinary.signedConfig(
    apiKey: "729881695894599",
    apiSecret: "iQLHhe3p7GDeb9qxVufzYLMO_G8",
    cloudName: "dxy0fr9yu",
  );
  String audioLink = "";
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

    _socket.on('error', (data) {
      print('Socket error: $data');
    });

    _socket.on('disconnect', (data) {
      print('Socket disconnected: $data');
    });

    _socket.on('connect', (data) {
      print('Socket Connected!!!!');
    });

    _socket.on('message', (data) {
      // Handle the received event data
      print('Received event: $data');
      _chatController.addToMessages(data);
    });

    _socket.on('read', (data) {
      // Handle the received event data
      print('Received event: $data');
      // _chatController.updateReadID(data["_chat"]);
      _chatController.markMessageRead(data["_chat"], userID);

    });

    // _socket.on('chat', (data) {
    //   // Handle the received event data
    //   print('Received event: $data');
    //   _chatController.updateLastMessageTime(data["chat"]);
    // });

    _socket.connect();

    setState(() {
      
    });
  }

  Future<void> startRecording() async {
    try{
      if(await audioRecord.hasPermission()){
        await audioRecord.start();

        setState((){
          isRecording = true;
        });
      }
      
    }catch(e){
      print(e);
    }
  }
  Future<void> stopRecording() async {
    try{
      String? path = await audioRecord.stop();
      setState((){
        isRecording = false;
        audioPath = path!;
        startPlayer = true;
      });

    }catch(e){
      print(e);
    }
  }
  Future<void> cancelRecording() async {
    try{
      await audioRecord.stop();
      setState(() {
        isRecording = false;
      });
    }catch(e){
      print(e);
    }
  }
  Future<void> sendRecording() async {
    try{
      final response = await cloudinary.upload(
          file: audioPath,
          resourceType: CloudinaryResourceType.raw,
          progressCallback: (count, total) {
            print(
                'Uploading image from file with progress: $count/$total');
          });
      if(response.isSuccessful) {
        print('Get your image from with ${response.secureUrl}');
        setState(() {
          audioLink = response.secureUrl!;
        });
      }
      _chatController.sendMessage("audio", audioLink, chatID);

      setState(() {
        startPlayer = false;

      });
    }catch(e){
      print(e);
    }
  }

  Future<void> playRecording() async{
    try{
      Source urlSource = UrlSource(audioPath);
      await audioPlayer.play(urlSource);

      setState((){
        isPlaying = true;
      });
    }catch(e){
      print(e);
    }
  }
  Future<void> pausePlayer() async{
    try{
      await audioPlayer.pause();

      setState((){
        isPlaying = false;
      });

    }catch(e){
      print(e);
    }
  }
  Future<void> cancelPlayer() async{
    try{
      await audioPlayer.stop();
      setState((){
        startPlayer = false;
      });

    }catch(e){
      print(e);
    }
  }
  Future<void> getRecording(String url) async{
    try {
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        )
      );
      print(response.data);
      if(response.statusCode == 200) {
        setState(() {
          print(response.data);
          audioPath = response.data;
          playRecording();
        });
      } else {
        print("Could not play audio!!");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState(); 
    audioPlayer = AudioPlayer();
    audioRecord = Record();
    _connectToSocket();
    _chatController.loadAllMessages(chatID);
    _chatController.markMessageRead(chatID, userID);
    _chatController.checkOnlineStatus(userID);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _socket.disconnect();
    audioPlayer.dispose();
    audioRecord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(senderAuth);
    return GetBuilder<ChatController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            height: Get.height,
            width: Get.width,
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Material(
                      elevation: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        color: const Color(0xffF9F9F9),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: const Icon(
                                      Iconsax.arrow_left,
                                      color: Color(0xff041C40),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: (userProfileImage == null)?
                                    const AssetImage("images/profileAvatar.png") as ImageProvider
                                    :
                                    NetworkImage(userProfileImage)
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "$userFirstName $userLastName",
                                        style: const TextStyle(
                                          color: Color(0xff0E0E0E),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 5,
                                            width: 5,
                                            decoration: BoxDecoration(
                                              color: (controller.online)?
                                              const Color(0xff3F9256)
                                              :
                                              const Color(0xffFF0000),
                                              shape: BoxShape.circle
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          (controller.online)?
                                          const Text(
                                            "Online",
                                            style: TextStyle(
                                              color: Color(0xff5E5E5E),
                                              fontSize: 12,
                                            ),
                                          )
                                          :
                                          // (controller.lastSeen != "")?
                                          // Text(
                                          //   "Last seen ${controller.lastSeen}",
                                          //   style: const TextStyle(
                                          //     color: Color(0xff5E5E5E),
                                          //     fontSize: 12,
                                          //   ),
                                          // )
                                          // :
                                          const Text(
                                            "Offline",
                                            style:  TextStyle(
                                              color: Color(0xff5E5E5E),
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Get.back();
                                    },
                                    child: const Icon(
                                      Iconsax.call,
                                      color: Color(0xff041C40),
                                      size: 25,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Get.back();
                                    },
                                    child: const Icon(
                                      Icons.more_vert,
                                      color: Color(0xff041C40),
                                      size: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 16,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                        child: 
                        (controller.allMessagesList.isEmpty)?
                        const Center(
                          child: Text(
                            "No messages"
                          ),
                        )
                        :
                        ListView.separated(
                          itemCount: controller.allMessagesList.length,
                          reverse: true,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemBuilder:(context, index) {
                            String timestamp = controller.allMessagesList[index]["sent"];
                            var dateTime = DateTime.parse(timestamp).toLocal();
                            var now = DateTime.now();
                            bool isToday = dateTime.year == now.year &&
                            dateTime.month == now.month &&
                            dateTime.day == now.day;

                            // Format date and time
                            String formattedDate;
                            if (isToday) {
                              formattedDate = 'Today';
                            } else {
                              formattedDate = DateFormat('d MMM, y').format(dateTime);
                            }

                            final formattedTime = DateFormat('h:mma').format(dateTime).toLowerCase();
                            return Align(
                              alignment: controller.allMessagesList[index]["SentByMe"]? Alignment.centerRight : Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: controller.allMessagesList[index]["SentByMe"]? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: controller.allMessagesList[index]["SentByMe"]?
                                      const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(2),
                                        topRight: Radius.circular(20),
                                      )
                                      :
                                      const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(2),
                                        bottomRight: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                      color: controller.allMessagesList[index]["SentByMe"]?
                                      const Color(0xffE3E9F1) 
                                      :
                                      const Color(0xffF2F2F2) 
                                    ),
                                    child: (controller.allMessagesList[index]["type"] == "text")?
                                    Text(
                                      controller.allMessagesList[index]["body"],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff0E0E0E),
                                      ),
                                    )
                                    :
                                    (controller.allMessagesList[index]["type"] == "image")?
                                    Image.network(
                                      controller.allMessagesList[index]["body"],
                                      height: 150,
                                      width: 200
                                    )
                                    :
                                    (controller.allMessagesList[index]["type"] == "video")?
                                    Image.network(
                                      controller.allMessagesList[index]["body"],
                                    )
                                    :
                                    (controller.allMessagesList[index]["type"] == "audio")?
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        (!isPlaying)?
                                        InkWell(
                                          onTap: (){
                                            getRecording(controller.allMessagesList[index]["body"]);
                                          },
                                          child: const Icon(
                                            Icons.play_arrow,
                                            color: Color(0xff0E0E0E),
                                            size: 20,
                                          ),
                                        )
                                            :
                                        InkWell(
                                          onTap: (){
                                            pausePlayer();
                                          },
                                          child: const Icon(
                                            Iconsax.pause5,
                                            color: Color(0xff0E0E0E),
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          (isPlaying)?
                                          "Playing"
                                          :
                                          "Play",
                                          style: const TextStyle(
                                            color: Color(0xff0E0E0E),
                                            fontSize: 14
                                          ),
                                        ),
                                      ],
                                    )
                                    :
                                    (controller.allMessagesList[index]["type"] == "file")?
                                    controller.thumbNail
                                    :
                                    controller.allMessagesList[index]["body"],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  (controller.allMessagesList[index]["SentByMe"])?
                                  Row(
                                    mainAxisAlignment: controller.allMessagesList[index]["SentByMe"]? MainAxisAlignment.end : MainAxisAlignment.start,
                                    children: [
                                      (!controller.allMessagesList[index]["read"])?
                                      SizedBox()
                                      :
                                      const Text(
                                        "Read",
                                        style: TextStyle(
                                            color: Color(0xff868686),
                                            fontSize: 14
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        formattedTime,
                                        style: const TextStyle(
                                          color: Color(0xff868686),
                                          fontSize: 14
                                        ),
                                      ),
                                    ],
                                  )
                                  :
                                  Text(
                                    formattedTime,
                                    style: const TextStyle(
                                        color: Color(0xff868686),
                                        fontSize: 14
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Material(
                      elevation: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        color: const Color(0xffF9F9F9),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Center(
                                child:
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: (isRecording)?
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            cancelRecording();
                                          },
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Color(0xff868686),
                                                fontSize: 12
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        const Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 4,
                                              backgroundColor: Color(0xffFF0000),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Recording...",
                                              style: TextStyle(
                                                  color: Color(0xff868686),
                                                  fontSize: 14
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                  :
                                  (startPlayer)?
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            (!isPlaying)?
                                              InkWell(
                                                onTap: (){
                                                  playRecording();
                                                },
                                                child: const Icon(
                                                  Icons.play_arrow,
                                                  color: Color(0xff868686),
                                                  size: 20,
                                                ),
                                              )
                                            :
                                            InkWell(
                                              onTap: (){
                                                pausePlayer();
                                              },
                                              child: const Icon(
                                                Iconsax.pause5,
                                                color: Color(0xff868686),
                                                size: 20,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Text(
                                              "Play Audio",
                                              style: TextStyle(
                                                  color: Color(0xff868686),
                                                  fontSize: 14
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: (){
                                            cancelPlayer();
                                          },
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Color(0xff868686),
                                                fontSize: 12
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  :
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: (){
                                            controller.toggleEmojiPicker();
                                            controller.focusNode.unfocus();
                                            controller.focusNode.canRequestFocus = true;
                                          },
                                          child: (controller.isEmojiVisible)?
                                          const Icon(
                                            Icons.emoji_emotions,
                                            color: Color(0xff041C40),
                                          )
                                          :
                                          const Icon(
                                            Icons.emoji_emotions_outlined,
                                            color: Color(0xffCFCFCF),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: TextFormField(
                                          controller: controller.msgController,
                                          focusNode: controller.focusNode,
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            enabledBorder:  OutlineInputBorder(
                                              borderSide: BorderSide.none
                                            ),
                                            focusedBorder:  OutlineInputBorder(
                                              borderSide: BorderSide.none
                                            ),
                                            labelText: "Write a message",
                                            labelStyle:  TextStyle(
                                              color: Color(0xffAFAFAF),
                                              fontSize: 16,
                                            ),
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                            contentPadding:  EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                          ),
                                          cursorColor: const Color(0xff041C40),
                                          onChanged: (value) {
                                            controller.updateMessageText(value);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                controller.getFile();
                                              },
                                              child: const Icon(
                                                Iconsax.link,
                                                color: Color(0xffCFCFCF),
                                              ),
                                            ),
                                            const SizedBox(width: 10,),
                                            InkWell(
                                              onTap: (){
                                                ChattingBottomSheetImage.showChattingBottomSheetImage(chatID);
                                              },
                                              child: const Icon(
                                                Iconsax.camera,
                                                color: Color(0xffCFCFCF),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: (controller.msgController.text != "")?
                                  InkWell(
                                    onTap: () {
                                      controller.sendMessage("text", controller.msgController.text, chatID);
                                      controller.msgController.text = "";

                                    },
                                    child: Container(
                                      height: 43,
                                      width: 43,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xff041C40)
                                      ),
                                      child: const Icon(
                                        Iconsax.send1,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                  :
                                  Container(
                                    height: 43,
                                    width: 43,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xff041C40)
                                    ),
                                    child: (isRecording)?
                                    InkWell(
                                      onTap: () {
                                        stopRecording();
                                      },
                                      child: const Icon(
                                        Iconsax.microphone_slash,
                                        color: Colors.white,
                                      ),
                                    )
                                    :
                                    (startPlayer)?
                                    InkWell(
                                      onTap: () {
                                        sendRecording();
                                      },
                                      child: const Icon(
                                        Iconsax.send1,
                                        color: Colors.white,
                                      ),
                                    )
                                    :
                                    InkWell(
                                      onTap: () {
                                        startRecording();
                                      },
                                      child: const Icon(
                                        Iconsax.microphone_2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ),

                  Offstage(
                    offstage: !controller.isEmojiVisible,
                    child: SizedBox(
                      height: 250,
                      child: EmojiPicker(
                        onEmojiSelected: (category, Emoji emoji) {
                          // Do something when emoji is tapped (optional)
                        },
                        onBackspacePressed: () {
                          // Do something when the user taps the backspace button (optional)
                          // Set it to null to hide the Backspace-Button
                        },
                        textEditingController: controller.msgController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
                        config: Config(
                          columns: 7,
                          emojiSizeMax: 32 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                          verticalSpacing: 0,
                          horizontalSpacing: 0,
                          gridPadding: EdgeInsets.zero,
                          initCategory: Category.RECENT,
                          bgColor: Color(0xFFF2F2F2),
                          indicatorColor: Colors.blue,
                          iconColor: Colors.grey,
                          iconColorSelected: Colors.blue,
                          backspaceColor: Colors.blue,
                          skinToneDialogBgColor: Colors.white,
                          skinToneIndicatorColor: Colors.grey,
                          enableSkinTones: true,
                          recentTabBehavior: RecentTabBehavior.RECENT,
                          recentsLimit: 28,
                          noRecents: const Text(
                            'No Recents',
                            style: TextStyle(fontSize: 20, color: Colors.black26),
                            textAlign: TextAlign.center,
                          ), // Needs to be const Widget
                          loadingIndicator: const SizedBox.shrink(), // Needs to be const Widget
                          tabIndicatorAnimDuration: kTabScrollDuration,
                          categoryIcons: const CategoryIcons(),
                          buttonMode: ButtonMode.MATERIAL,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}