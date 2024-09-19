import 'dart:convert';
import 'dart:typed_data';

import 'package:image/image.dart';



Future imgConvert(bytes) async {

  final Image? image = decodeImage(bytes);
  final Image thumbnail = copyResize(image!, width: 300, height: 200);
  final  resizedData = encodeJpg(thumbnail);
  final imgData1 = base64.encode(resizedData);
  return imgData1;
}