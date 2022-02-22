import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/pages/chat_page.dart';
import 'package:flutter_chat/utils/auth_service.dart';
import 'package:flutter_chat/widgets/anim_title.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final users = List.generate(20, (index) => 'Gutlo');
  final _scaffKey = GlobalKey<ScaffoldState>();
  var msgs = {};

  loadChats() {
    final debUsers = ['Gutlo'];
    for (var user in debUsers) {
      var chats = FirebaseDatabase.instance.ref('chats/$user');
      msgs[user] = <String>[];
      chats.get().then((value) {
        value.children.every((element) {
          msgs[user].add(element.value.toString());
          setState(() {});
          return true;
        });
        // setState(() {});
        // debugPrint();
        // var _l = jsonDecode(v);
        // messages = _l;
      });
      // msgs[user] = messages;
      // setState(() {});
      debugPrint('Initialized Chats : $chats');
    }
  }

  @override
  void initState() {
    super.initState();
    loadChats();
  }

  @override
  Widget build(BuildContext context) {
    // loadChats();
    return Scaffold(
      // rgba(10,11,11,255)
      key: _scaffKey,
      backgroundColor: const Color.fromARGB(255, 10, 11, 11),
      endDrawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextButton(
                onPressed: () {
                  context.read<AuthService>().signOut();
                },
                child: const Text('Sign Out'),
              ),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.black26,
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AnimatedTitle(),
                  Row(
                    children: [
                      Ink(
                        child: Center(
                          child: IconButton(
                            splashRadius: 25,
                            iconSize: 15,
                            onPressed: () {},
                            icon: const FaIcon(
                              FontAwesomeIcons.userPlus,
                            ),
                            //rgba(162,162,166,255)
                            color: const Color.fromARGB(255, 162, 162, 166),
                          ),
                        ),
                        decoration: BoxDecoration(
                          //rgba(43,43,43,255)
                          color: const Color.fromARGB(255, 43, 43, 43),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Badge(
                        child: InkWell(
                          child: const CircleAvatar(
                            radius: 20,
                            foregroundImage: NetworkImage(
                                'http://www.playtoearn.online/wp-content/uploads/2021/10/Bored-Ape-Yacht-Club-NFT-avatar.png'),
                          ),
                          onTap: () {
                            _scaffKey.currentState?.openEndDrawer();
                          },
                        ),
                        badgeColor: const Color.fromARGB(255, 89, 238, 94),
                        position: BadgePosition.bottomEnd(
                          end: -2,
                          bottom: -2,
                        ),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 10, 11, 11),
                          width: 3,
                        ),
                        padding: const EdgeInsets.all(8),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Chats",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "New Group",
                    style: TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    var l = msgs[users[index]].length;
                    var lastmessage = (msgs[users[index]].isEmpty)
                        ? 'Loading...'
                        : msgs[users[index]][l - 1];
                    return Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: ListTile(
                        minLeadingWidth: 0,
                        title: Text(
                          users[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          lastmessage,
                        ),
                        trailing: Badge(
                          padding: const EdgeInsets.all(10),
                          badgeContent: const Text(
                            '1',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          badgeColor: Colors.blue,
                        ),
                        leading: Hero(
                          tag: Key('user_avatar_$index'),
                          child: Badge(
                            badgeColor: Colors.green,
                            position: BadgePosition.bottomEnd(
                              bottom: 0,
                              end: 0,
                            ),
                            padding: const EdgeInsets.all(8),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 10, 11, 11),
                              width: 3,
                            ),
                            child: GestureDetector(
                              child: const CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.teal,
                                foregroundImage: NetworkImage(
                                  'https://pbs.twimg.com/media/FCQddC_WYAEzxfA?format=jpg&name=large',
                                ),
                              ),
                              onLongPress: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: 400,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fitHeight,
                                          image: NetworkImage(
                                            'https://pbs.twimg.com/media/FCQddC_WYAEzxfA?format=jpg&name=large',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (cotext) => ChatPage(
                                index: index,
                                name: users[index],
                                messages: msgs[users[index]],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
