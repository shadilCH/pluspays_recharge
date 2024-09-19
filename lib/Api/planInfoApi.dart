import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pluspay/Const/network.dart';
import 'package:pluspay/Const/sharedPref.dart';







Future planInfoApi(skucode) async {


  var token = await getSharedPrefrence('token');
  var id =   await getSharedPrefrence('userId');
  var dash =   await getSharedPrefrence('dash');
  print(token);
  print(dash);

  final response = await http.post(Uri.parse( baseUrl+planInfoUrl),
  headers: {"Content-Type": 'application/x-www-form-urlencoded',
    "access-token": token,
    "user-id": id,
    "server-sslkey": serverKey},
    encoding: Encoding.getByName('utf-8'),
  body: {
  'dash':dash,
  'SkuCode':skucode,





  },
  );
  var convertDataToJson;

  if (response.statusCode == 200) {
    convertDataToJson = json.decode(response.body);
    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    convertDataToJson = 0;

  }


  return convertDataToJson;
}