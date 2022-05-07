import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedTitle extends StatelessWidget {
  final String text;
  const AnimatedTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width * 50 / 100,
      child: AnimatedTextKit(
        animatedTexts: [
          ColorizeAnimatedText(
            text,
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
        ],
        isRepeatingAnimation: true,
        repeatForever: true,
      ),
    );
  }
}
