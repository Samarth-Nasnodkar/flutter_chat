import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Message {}

class TextMessage extends Message {
  late String content;

  TextMessage({required this.content});
}

class FileMessage extends Message {
  late String fileURL;

  FileMessage({required this.fileURL});
}

Widget getMessage(Message message) {
  if (message is TextMessage) {
    return Text(
      message.content,
      textAlign: TextAlign.end,
      // softWrap: true,
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  } else if (message is FileMessage) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CachedNetworkImage(
        width: 300,
        height: 400,
        imageUrl: message.fileURL,
        fit: BoxFit.fitHeight,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: SizedBox(
            child: CircularProgressIndicator.adaptive(
              value: downloadProgress.progress,
              backgroundColor: const Color.fromARGB(255, 95, 87, 235),
            ),
            width: 40,
            height: 40,
          ),
        ),
      ),
    );
  }

  return const Placeholder(
    color: Colors.white,
  );
}
