import 'dart:ui';

import 'package:flutter/material.dart';

const darkBlue = Color(0xffE80586);
const liteBlue = Color(0xff96c5e2);

const grad = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[darkBlue, liteBlue]);
const grad2 = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: <Color>[darkBlue, liteBlue]);
const receiptbold = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
