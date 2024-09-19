import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pluspay/Const/network.dart';
import 'package:pluspay/Const/sharedPref.dart';
import 'package:pluspay/Const/snackbar_toast_helper.dart';







Future customHomeRcData(mobile,amount) async {


  var token = await getSharedPrefrence('token');
  var id =   await getSharedPrefrence('userId');
  var dash =   await getSharedPrefrence('dash');

  // token ="Xu8o98zS8beWYghH+9VIBVux1wRS+Sm2A6v05CP0kA";
  // id= "16";
  final response = await http.post(Uri.parse( baseUrl+getCustomAmountUrl),
  headers: {"Content-Type": 'application/x-www-form-urlencoded',
    "access-token": token,
    "user-id": id,
    "server-sslkey": serverKey},
    encoding: Encoding.getByName('utf-8'),
  body: {

  'amount':amount,
  'mobile':mobile,





  },
  );
  var convertDataToJson;

  if (response.statusCode == 200) {
    convertDataToJson = json.decode(response.body);
    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    convertDataToJson = 0;
    showToast(response.body.toString());

  }


  return convertDataToJson;
}