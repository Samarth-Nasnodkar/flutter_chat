import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  const ChatMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        // width: MediaQuery.of(context).size.width * 50 / 100,
        alignment: Alignment.centerRight,
        child: Text(
          message,
        ),
        decoration: BoxDecoration(
          // rgba(95,90,235,255)
          color: const Color.fromARGB(255, 95, 90, 235),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
