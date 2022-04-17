import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/utils/message.dart';
// import 'package:flutter_chat/widgets/chat_message.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  final int index;
  final String name;
  final List<Message> messages;

  const ChatPage(
      {Key? key,
      required this.index,
      required this.name,
      required this.messages})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // final database = FirebaseDatabase.instance.ref('chats/').push();
  late DatabaseReference chats;
  List<Message> messages = <Message>[];
  final _textController = TextEditingController();

  @override
  void initState() {
    chats = FirebaseDatabase.instance.ref('chats/${widget.name}');
    messages.clear();
    super.initState();
    updateMessages();
  }

  void updateMessages() {
    chats.onChildAdded.listen((event) {
      final _jdata = event.snapshot.value;
      if (_jdata is! Map) {
        debugPrint("Unknown error! _jdata = $_jdata");
        return;
      }
      if (_jdata["type"] == "s") {
        messages.add(TextMessage(content: _jdata["data"]));
      } else if (_jdata["type"] == "f") {
        messages.add(FileMessage(fileURL: _jdata["data"]));
      } else {
        debugPrint("Unknown error! _jdata = $_jdata");
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 11, 11),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        // leadingWidth: 40,
        // rgba(31,31,30,255)
        backgroundColor: const Color.fromARGB(255, 31, 31, 30),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Ink(
            child: IconButton(
              iconSize: 20,
              splashRadius: 20,
              icon: const FaIcon(FontAwesomeIcons.angleLeft),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.grey,
            ),
            decoration: BoxDecoration(
              // rgba(59,58,61,255)
              color: const Color.fromARGB(255, 59, 58, 61),
              // shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   width: 60,
            // ),
            Hero(
              tag: Key('user_avatar_${widget.index}'),
              child: Badge(
                toAnimate: false,
                badgeColor: Colors.green,
                position: BadgePosition.bottomEnd(
                  bottom: 0,
                  end: 0,
                ),
                padding: const EdgeInsets.all(6),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 10, 11, 11),
                  width: 3,
                ),
                child: const CircleAvatar(
                  radius: 15,
                  foregroundImage: NetworkImage(
                      'https://pbs.twimg.com/media/FCQddC_WYAEzxfA?format=jpg&name=large'),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const FaIcon(
              FontAwesomeIcons.angleRight,
              size: 20,
              color: Colors.grey,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              left: 5.0,
              // right: 5.0,
              top: 10,
              bottom: 10,
            ),
            child: Ink(
              child: IconButton(
                splashRadius: 18,
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.phoneAlt,
                ),
                color: const Color.fromARGB(255, 95, 87, 235),
                iconSize: 16,
              ),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 59, 58, 61),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              // left: 5.0,
              right: 5.0,
              top: 10,
              bottom: 10,
            ),
            child: Ink(
              child: IconButton(
                splashRadius: 18,
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.video,
                ),
                color: const Color.fromARGB(255, 95, 87, 235),
                iconSize: 16,
              ),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 59, 58, 61),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          // mainAxisAlignment: MainAxisAlignment.end,
          // mainAxisSize: MainAxisSize.min,

          children: [
            Flexible(
              fit: FlexFit.tight,
              child: ListView.builder(
                reverse: true,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                // itemExtent: 40,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                dragStartBehavior: DragStartBehavior.down,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  index = messages.length - 1 - index;
                  final msg = messages[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: (msg is TextMessage)
                            ? Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  // color: const Color.fromARGB(255, 95, 90, 235),
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromARGB(255, 63, 57, 233),
                                      Color.fromARGB(255, 19, 105, 175),
                                    ],
                                  ),
                                ),
                                constraints: BoxConstraints(
                                  maxWidth: screenSize.width * 60 / 100,
                                ),
                                child: getMessage(msg),
                              )
                            : (msg is FileMessage)
                                ? GestureDetector(
                                    child: Container(
                                      padding: const EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        // color: const Color.fromARGB(255, 95, 90, 235),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      constraints: BoxConstraints(
                                        maxWidth: screenSize.width * 60 / 100,
                                      ),
                                      child: getMessage(msg),
                                    ),
                                    onTap: () async {
                                      showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) {
                                          return BackdropFilter(
                                            filter: ImageFilter.blur(
                                              sigmaX: 20,
                                              sigmaY: 20,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 40.0,
                                                    right: 20,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(
                                                        Icons.close,
                                                        size: 30,
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: InteractiveViewer(
                                                    panEnabled: true,
                                                    child: CachedNetworkImage(
                                                      imageUrl: msg.fileURL,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              90 /
                                                              100,
                                                      fit: BoxFit.fitWidth,
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  downloadProgress) =>
                                                              Center(
                                                        child: SizedBox(
                                                          child:
                                                              CircularProgressIndicator
                                                                  .adaptive(
                                                            value:
                                                                downloadProgress
                                                                    .progress,
                                                            backgroundColor:
                                                                const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    95,
                                                                    87,
                                                                    235),
                                                          ),
                                                          width: 40,
                                                          height: 40,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  )
                                : Container(),
                      ),
                    ],
                  );
                },
              ),
            ),

            // decoration: BoxDecoration(
            //   color: const Color.fromARGB(255, 10, 11, 11),
            //   backgroundBlendMode: BlendMode.clear,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 5,
                ),
                Ink(
                  child: IconButton(
                    onPressed: () async {
                      final imagePicker = ImagePicker();
                      final _file = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      // debugPrint("Uploading file...");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Uploading Image...'),
                          duration: Duration(seconds: 30),
                        ),
                      );
                      String _f = _file?.path ?? "lol";
                      // debugPrint("_f = $_f");
                      final _up = FirebaseStorage.instance
                          .ref()
                          .child("files/${widget.name}/${_file?.name}")
                          .putFile(File(_f));
                      final ss = await _up.whenComplete(() {});
                      final downloadUrl = await ss.ref.getDownloadURL();
                      chats.push().set({
                        "type": "f",
                        "data": downloadUrl,
                      });
                      messages.add(FileMessage(fileURL: downloadUrl));
                      // debugPrint("Uploaded File!!!");
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      setState(() {});
                    },
                    icon: const FaIcon(FontAwesomeIcons.plusCircle),
                    color: const Color.fromARGB(255, 10, 11, 11),
                    iconSize: 20,
                  ),
                  decoration: const BoxDecoration(
                    // rgba(74,173,209,255)
                    color: Color.fromARGB(255, 74, 173, 209),
                    backgroundBlendMode: BlendMode.difference,
                    shape: BoxShape.circle,
                  ),
                  width: 40,
                  height: 40,
                ),
                // const SizedBox(
                //   width: 10,
                // ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width * 70 / 100,
                  height: 40,
                  child: TextField(
                    onSubmitted: (value) {
                      _textController.clear();
                      messages.add(TextMessage(content: value));
                      chats.push().set({
                        "type": "s",
                        "data": value,
                      });
                      setState(() {});
                    },
                    controller: _textController,
                    textAlign: TextAlign.left,
                    // textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 10),
                      hintText: 'Message...',
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: FaIcon(
                          FontAwesomeIcons.solidLaughWink,
                          // rgba(164,165,170,255)
                          color: Color.fromARGB(255, 164, 165, 170),
                        ),
                      ),
                      suffixIconConstraints: BoxConstraints(
                        maxWidth: 30,
                        maxHeight: 30,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                  decoration: BoxDecoration(
                    // rgba(59,58,61,255)
                    color: const Color.fromARGB(255, 59, 58, 61),
                    borderRadius: BorderRadius.circular(25),
                    // shape: BoxShape.circle,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  splashRadius: 25,
                  icon: const FaIcon(
                    FontAwesomeIcons.microphone,
                    color: Color.fromARGB(255, 164, 165, 170),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
