import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pluspay/Const/network.dart';
import 'package:pluspay/Const/sharedPref.dart';
import 'package:pluspay/Const/snackbar_toast_helper.dart';







Future VoucherRechargeApi(providerCode,AccountNumber,amount,SkuCode,ReceiveValue,CoupenTitle,type,SendValue,custom,customAmount) async {

  var token = await getSharedPrefrence('token');


  var id =   await getSharedPrefrence('userId');
  var dash =   await getSharedPrefrence('dash');
  print("iddddddd");
  print(id);
  print(token);
  print("prontttttttttt");
  print(AccountNumber + " AccountNumber");
  //print(amount + " amount");
  print(type + " type");
  print(dash+ " dash");
  print(providerCode+ " providerCode");
  print(SkuCode+ " SkuCode");
  print(SendValue+ " SendValue");
  print(ReceiveValue+ " ReceiveValue");
  print(CoupenTitle+ " CoupenTitle");

  final response = await http.post(Uri.parse( baseUrl+rechargeNow_VoucherUrl),
  headers: {"Content-Type": 'application/x-www-form-urlencoded',
    "access-token": token,
    "user-id": id,
    "server-sslkey": serverKey},
    encoding: Encoding.getByName('utf-8'),
  body: {
  'ProviderCode':providerCode,
    'amount':custom==true?customAmount:SendValue,
    'SkuCode':SkuCode,
    'ReceiveValue':ReceiveValue,  ///--> postpaid amount

  //   'type':type, ///--> post paid = 2, pre paid  = 1
  // 'AccountNumber':AccountNumber,
  //
  //
  // 'Dash':dash,
  // 'CoupenTitle':CoupenTitle,
  // 'IsCustom':custom==true?"1":"0",




  },
  );
  var convertDataToJson;

  if (response.statusCode == 200) {
    convertDataToJson = json.decode(response.body);
    print("response.body");
    print(response.body);
    showToast(response.body.toString());
    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    convertDataToJson = 0;
    print("response.body");

    print(response.body);

    showToast(response.body.toString());
  }


  return convertDataToJson;
}