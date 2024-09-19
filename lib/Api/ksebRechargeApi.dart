import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pluspay/Const/network.dart';
import 'package:pluspay/Const/sharedPref.dart';







Future ksebRechargeApi(consumer_number,amount) async {


  var token = await getSharedPrefrence('token');
  var id =   await getSharedPrefrence('userId');


  final response = await http.post(Uri.parse( baseUrl+ksebRechargeUrl),
  headers: {"Content-Type": 'application/x-www-form-urlencoded',
    "access-token": token,
    "user-id": id,
    "server-sslkey": serverKey
  },
    encoding: Encoding.getByName('utf-8'),

    body: {
      "consumer_number": consumer_number,
      "amount": amount,




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