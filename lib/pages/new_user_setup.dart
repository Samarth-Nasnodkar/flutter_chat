import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/pages/chat_page.dart';
import 'package:flutter_chat/pages/home_page.dart';
import 'package:flutter_chat/widgets/auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewUserSetup extends StatelessWidget {
  final String email;
  const NewUserSetup({Key? key, required this.email}) : super(key: key);
  final url =
      "https://avatars.dicebear.com/api/micah/bruh.svg?radius=50&background=%23283747";
  final double dim = 100;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 10, 11, 11),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const TitleText(),
            UsernameField(
              email: email,
            )
          ],
        ),
      ),
    );
  }
}

class UsernameField extends StatefulWidget {
  final String email;
  const UsernameField({Key? key, required this.email}) : super(key: key);

  @override
  State<UsernameField> createState() => _UsernameFieldState();
}

class _UsernameFieldState extends State<UsernameField> {
  final usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    usernameController.text = widget.email.replaceAll("@gmail.com", "");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          UserAvatar(
            dim: 150,
            username: usernameController.text,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 90 / 100,
              height: 100,
              child: TextField(
                maxLength: 25,
                onChanged: (value) {
                  setState(() {});
                },
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Choose a Username",
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      // rgba(120,53,106,255)
                      color: Color.fromARGB(255, 120, 53, 106),
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      // rgba(120,53,106,255)
                      color: Colors.grey.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            // margin: const EdgeInsets.only(left: 30.0),
            padding: const EdgeInsets.all(3.0),
            // width: 70,
            child: TextButton(
              onPressed: () async {
                var usrname = usernameController.text;
                var ref = FirebaseStorage.instance.ref();
                showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: CircularProgressIndicator.adaptive(),
                    );
                  },
                );
                final jsonData = {
                  "username": usrname,
                  "avatarUrl":
                      "https://avatars.dicebear.com/api/micah/$usrname.svg?radius=50&background=%23283747",
                };
                await ref
                    .child("users/${widget.email}")
                    .putString(jsonEncode(jsonData));
                Navigator.pop(context);
                AuthWrapper.userData = jsonData;
              },
              style: TextButton.styleFrom(
                elevation: 0,
                splashFactory: NoSplash.splashFactory,
              ),
              child: const Text(
                "Confirm Username",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 120, 53, 106),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 50,
            height: 50,
            child: InkWell(
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName("/"));
              },
              child: Container(
                child: const Center(
                  child: FaIcon(FontAwesomeIcons.angleLeft),
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 10, 11, 11),
                  borderRadius: BorderRadius.circular(15),
                  // border: Border.all(
                  //   color: Color.fromARGB(255, 87, 84, 84),
                  // ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.5,
                      blurRadius: 3,
                      // offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0, top: 8.0),
          child: Text(
            "Create ",
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            "Account.",
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    required this.dim,
    required this.username,
  }) : super(key: key);

  final double dim;
  final String username;

  @override
  Widget build(BuildContext context) {
    String url =
        "https://avatars.dicebear.com/api/micah/$username.svg?radius=50&background=%23283747";
    return Container(
      width: dim,
      height: dim,
      child: SvgPicture.network(
        url,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 140, 53, 106),
          width: 5,
        ),
        borderRadius: BorderRadius.circular(dim / 2),
      ),
    );
  }
}
