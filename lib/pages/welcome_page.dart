import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 120, 53, 106),
          ),
          Positioned(
            right: -130,
            top: -60,
            child: Container(
              width: 400,
              height: 400,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 140, 53, 106),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(120, 140, 53, 106),
                    blurRadius: 3,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage("assets/icons/new_icon.png"),
                  width: 120,
                  height: 120,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "Chatty",
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: GoogleFonts.secularOne().fontFamily,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Container(
                  // padding: const EdgeInsets.only(left: 10, right: 10),
                  width: MediaQuery.of(context).size.width * 80 / 100,
                  height: 50,
                  child: InkWell(
                    onTap: () {
                      debugPrint("Clicked");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AuthWrapper(indx: 1)));
                    },
                    child: const Center(
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 171, 67, 131),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(120, 156, 41, 112),
                        spreadRadius: 4,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(text: "Don't have an account? ", children: [
                    TextSpan(
                      text: " Sign Up",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          debugPrint("Sign Up clicked!");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AuthWrapper(indx: 2)));
                        },
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
