import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pluspay/Const/network.dart';






Future loginApi(name,pass) async {



  print("name");
  print(name);
  print(pass);

  final response = await http.post(Uri.parse( baseUrl+loginUrl),
    headers: {
    "Content-Type": 'application/x-www-form-urlencoded',
      'server-sslkey':'7f88838a7d63896460bddde5bdd8dcc39be802297cdd76aaf9e6e6b97a4f18377c'},
    encoding: Encoding.getByName('utf-8'),
    body: {
      "username": name,
      "password": pass,



    },
  );
  var convertDataToJson;

  if (response.statusCode == 200) {
    convertDataToJson = json.decode(response.body);
    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    convertDataToJson = "Something went wrong! :(";
    // If the server did not return a 200 OK response,
    // then throw an exception.
  }


  return convertDataToJson;
}