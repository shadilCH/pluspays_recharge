import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// customSnackBar(BuildContext context, String msg,GlobalKey<ScaffoldState> key,int seconds) {
//   final SnackBar snackBar = SnackBar(
//     backgroundColor: Colors.green,
//     content: Text(msg,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
//     duration: Duration(seconds: seconds),
//
//   );
//   // ignore: deprecated_member_use
//   key.currentState.showSnackBar(snackBar);
// }

showToastError(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,

      textColor: Colors.black,
      fontSize: 16.0
  );
}


showToast(String message){
return  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,

      textColor: Colors.black,
      fontSize: 16.0
  );
}
void customSnackBar(BuildContext context, String msg, int seconds, int i) {
  final SnackBar snackBar = SnackBar(
    backgroundColor: Colors.green,
    content: Text(
      msg,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    duration: Duration(seconds: seconds),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
