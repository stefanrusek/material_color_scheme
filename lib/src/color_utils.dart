import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

Color darken(Color c) => Color.fromARGB(
    -1,
    (c.red * c.red) ~/ 255,
    (c.green * c.green) ~/ 255,
    (c.blue * c.blue) ~/ 255);

Color lighten(Color c) => Color.fromARGB(
    -1,
    (sqrt(c.red / 255) * 255).floor(),
    (sqrt(c.green / 255) * 255).floor(),
    (sqrt(c.blue / 255) * 255).floor());

Color tweak(Color base, double bf, double df, double lf, double wf, {Color? darker, Color? lighter}) {
  if (darker == null) darker = darken(base);
  if (lighter == null) lighter = lighten(base);
  return Color.lerp(Colors.black, Color.lerp(Colors.white, Color.lerp(darker, Color.lerp(lighter, base, lf), df), wf), bf)!;
}