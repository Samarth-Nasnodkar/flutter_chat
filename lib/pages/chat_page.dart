import 'package:badges/badges.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_chat/widgets/chat_message.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatPage extends StatefulWidget {
  final int index;
  final String name;
  final List<String> messages;

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
  List<String> messages = <String>[];
  final _textController = TextEditingController();

  @override
  void initState() {
    chats = FirebaseDatabase.instance.ref('chats/${widget.name}');
    // chats.once().then((value) {
    //   value.snapshot.children.every((element) {
    //     messages.add(element.value.toString());
    //     return true;
    //   });
    //   setState(() {});
    //   // debugPrint();
    //   // var _l = jsonDecode(v);
    //   // messages = _l;
    // });
    // debugPrint('Initialized Chats : $chats');
    messages = widget.messages;
    super.initState();
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
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
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
                          child: Text(
                            messages[index],
                            textAlign: TextAlign.end,
                            // softWrap: true,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
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
                    onPressed: () {},
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
                      messages.insert(0, value);
                      chats.push().set(value);
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
