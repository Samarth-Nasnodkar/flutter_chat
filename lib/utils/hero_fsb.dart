import 'package:flutter/material.dart';

Widget customFSB(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return DefaultTextStyle(
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    child: toHeroContext.widget,
  );
}
