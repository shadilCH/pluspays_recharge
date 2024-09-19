import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final themeBlue = Color(0xff06ACE8);
final themePink = Color(0xffE80586);
// final themePink = Color(0xff);
final themeColor = Color(0xff06ace8);
final greyColor = Color(0xffB0BCD5);
final INR = "INR";
final SAR = "SAR";
final rupee = "SAR ";

int hexOfRGB(int r, int g, int b) {
  r = (r < 0) ? -r : r;
  g = (g < 0) ? -g : g;
  b = (b < 0) ? -b : b;
  r = (r > 255) ? 255 : r;
  g = (g > 255) ? 255 : g;
  b = (b > 255) ? 255 : b;
  return int.parse(
      '0xff${r.toRadixString(16)}${g.toRadixString(16)}${b.toRadixString(16)}');
}

final txt14SemiWhite = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: Colors.white,
  fontFamily: 'Poppins',
);
final bold14 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  fontFamily: 'Poppins',
);
final size14_400G = TextStyle(
    fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff3E3E3E));
