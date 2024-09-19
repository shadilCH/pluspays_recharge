import 'dart:typed_data';
import 'package:image/image.dart';





Future resizeImage(Uint8List data)async {
  Uint8List resizedData = data;
  final Image? image = decodeImage(data);
  Image resized = copyResize(image!, width: 110,height: 70);
  resizedData = encodeJpg(resized);
  return resizedData;
}