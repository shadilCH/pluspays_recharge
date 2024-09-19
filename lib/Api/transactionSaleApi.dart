import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pluspay/Const/network.dart';
import 'package:pluspay/Const/sharedPref.dart';







Future transactionSaleApi(start,end) async {
     print("date");
     print(start);
     print(end);

  var token = await getSharedPrefrence('token');
  var id =   await getSharedPrefrence('userId');
  var dash =   await getSharedPrefrence('dash');


  final response = await http.post(Uri.parse( baseUrl+transactionSaleUrl),
  headers: {"Content-Type": 'application/x-www-form-urlencoded',
    "access-token": token,
    "user-id": id,
    "server-sslkey": serverKey},
    encoding: Encoding.getByName('utf-8'),
  body: {
  'Dash':dash,
  'sdate':start,
  'edate':end,


  },
  );
  var convertDataToJson;

  if (response.statusCode == 200) {
    convertDataToJson = json.decode(response.body);   print("response.body");
    print(response.body);

    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    convertDataToJson = "Something went wrong! :(";
    print("response.body");
    print(response.body);

  }


  return convertDataToJson;
}