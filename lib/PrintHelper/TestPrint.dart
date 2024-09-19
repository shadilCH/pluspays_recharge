
import 'dart:async';


import 'dart:typed_data';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';

import 'package:image/image.dart';
import 'package:pluspay/Const/Constants.dart';
import 'package:pluspay/Const/network.dart';
import 'package:pluspay/Const/sharedPref.dart';
import 'package:pluspay/Const/snackbar_toast_helper.dart';

var  isLoading = true;
var sold_on ="";
var trans_id ="";
var barcode ="";
var card_name ="";
var MRP ="";
var info ="";
var serial_number ="";
var code ="";
var name ="";
var catname ="";
var user_name ="";
var password ="";
var icon ="";
var exp_date ="";
var nowDate ="";
var nowTime ="";
var size_min ="";
var bal_check ="";

var RechargeID ="";
var RechargeType ="";
var TransactionID ="";
var AccountNumber ="";
var coupen_info ="";
var recharge_amount ="";
var provider_name ="";
var CountryName ="";

var RechargedTime ="";
var shop_name ="";
var location ="";



var recharge_info ="";
var voucher_info ="";

Timer? timer;
DateTime now = DateTime.now();
var nwdate=DateTime.now().year.toString()+"-"+ DateTime.now().month.toString()+"-"+ DateTime.now().day.toString();

Future<String> getHome(rsp) async {

  var sucess ="NO";


  if(rsp['status']==true){
   // showToast("Printing Started...");
    var getname = await getSharedPrefrence('name');


    TransactionID =rsp['recharge_info']['TransactionID'].toString();
    AccountNumber =rsp['recharge_info']['AccountNumber'].toString();
    recharge_amount =rsp['recharge_info']['recharge_amount'].toString();
    provider_name =rsp['recharge_info']['provider_name'].toString();
    CountryName =rsp['recharge_info']['CountryName'].toString();
    RechargedTime =rsp['recharge_info']['RechargedTime'].toString();
    shop_name =rsp['recharge_info']['shop_name'].toString();
    coupen_info =rsp['recharge_info']['coupen_info'].toString();
    location =rsp['recharge_info']['location'].toString();
    RechargeType = rsp['recharge_info']['RechargeType'].toString() =="1"?"PREPAID":"POSTPAID";
    RechargeID =rsp['recharge_info']['RechargeID'].toString();

    recharge_info =rsp['recharge_info']['recharge_info'].toString();
    voucher_info =rsp['recharge_info']['voucher_info'].toString();

      nowDate =DateTime.now().year.toString()+"-"+ DateTime.now().month.toString()+"-"+ DateTime.now().day.toString();
      nowTime =now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString();
      name= getname;
    BlueThermalPrinter SunmiPrinter = BlueThermalPrinter.instance;
    SunmiPrinter.isConnected.then((isConnected)async {
      var rsp =  await _ticket();
      print("rspppppppp");
      print(rsp);
      sucess = rsp;
    }).onError((error, stackTrace){
      showToast("No Devices Connected!");
    });

  }

  print("ingatuuuuu");
  print(rsp);

  return sucess;

}



Future<String> _ticket()async{


  BlueThermalPrinter SunmiPrinter = BlueThermalPrinter.instance;
  final ByteData data = await NetworkAssetBundle(Uri.parse(pluspayImgUrl)).load("");
  final Uint8List bytes = data.buffer.asUint8List();
  final Image? image = decodeImage(bytes);
  final Image thumbnail = copyResize(image!, width: 110,height: 70);
  final  resizedData = encodeJpg(thumbnail);

  ///barcode


  final ByteData data2 = await NetworkAssetBundle(Uri.parse(barcodeImgUrl)).load("");
  final Uint8List bytes2 = data2.buffer.asUint8List();
  final Image? image2 = decodeImage(bytes2);
  final Image thumbnail2 = copyResize(image2!, width: 110,height: 80);
  final  resizedData2 = encodeJpg(thumbnail2);
  showToast("Printing...");
  SunmiPrinter.isConnected.then((isConnected) {
    if (isConnected!) {
   // SunmiPrinter.printImageBytes(resizedData);
    SunmiPrinter.printNewLine();








    /// logo



    SunmiPrinter.printImageBytes(resizedData);

    //SunmiPrinter.emptyLines(1);
    /// url
    SunmiPrinter.printCustom("www.plexpays.in",1,1);

    //
    // ///   barcode
    // SunmiPrinter.printImageBytes(resizedData2);



    SunmiPrinter.printNewLine();

    //   SunmiPrinter.hr();

    ///  now date

    SunmiPrinter.printCustom(DateTime.now().toString(),1,1);



    SunmiPrinter.printNewLine();

    ///datas ->






    SunmiPrinter.printCustom("RECEIPT NO    :  "+DateTime.now().millisecond.toString(),1,1);




    if( shop_name.toString()!="null"){

      SunmiPrinter.printCustom( "SHOP NAME    :  "+name.toString(),1,1);


    }

    if( TransactionID.toString()!="null"){
      SunmiPrinter.printCustom(  "RECHARGE ID   :  "+TransactionID.toString(),1,1);


    }

    if( RechargeID.toString()!="null"){
      SunmiPrinter.printCustom("RECHARGE ID      :  "+RechargeID.toString(),1,1);

    }
    if( coupen_info.toString()!="null"){
      SunmiPrinter.printCustom( "COUPON INFO      :  "+coupen_info.toString(),1,1);


    }

    if( recharge_info.toString()!="null"){
      SunmiPrinter.printCustom( "RECHARGE INFO      :  "+recharge_info.toString(),1,1);


    }
    if( voucher_info.toString()!="null"){
      SunmiPrinter.printCustom( "VOUCHER INFO      :  "+voucher_info.toString(),1,1);


    }
    if( provider_name.toString()!="null"){
      SunmiPrinter.printCustom("PROVIDER NAME      :  "+provider_name.toString(),1,1);


    }
    if( location.toString()!="null"){
      SunmiPrinter.printCustom( "LOCATION      :  "+location.toString(),1,1);


    }
    if( AccountNumber.toString()!="null"){
      SunmiPrinter.printCustom( "MOBILE NUMBER :  "+AccountNumber.toString(),1,1);


    }

    if( RechargeType.toString()!="null"){
      SunmiPrinter.printCustom("TYPE          :  "+RechargeType.toString(),1,1);


    }

    if( recharge_amount.toString()!="null"){
      SunmiPrinter.printCustom( "AMOUNT        :  "+recharge_amount.toString(),1,1);


    }


    if( RechargedTime.toString()!="null"){
      SunmiPrinter.printCustom("DATE & TIME   :  "+RechargedTime.toString(),1,1);


    }




    SunmiPrinter.printCustom("STATUS        :  "+"SUCCESS",1,1);



    SunmiPrinter.printNewLine();
    SunmiPrinter.printNewLine();






    showToast("Print Completed");


    }else{
      showToast("No Devices Connected!");
    }
  });


   return "OK";
}


Future<String> listPrint(title,data,date)async{


  BlueThermalPrinter SunmiPrinter = BlueThermalPrinter.instance;

  showToast("Printing...");
  SunmiPrinter.isConnected.then((isConnected) {
    if (isConnected!) {
      SunmiPrinter.printCustom('Plus Pays', 1,1);
      SunmiPrinter.printCustom(
        title, 1,1,
      );
      SunmiPrinter.printCustom(
        date,
        1,1,
      );
      for (var i = 0; i < data.length; i++) {
        print("workk");


        SunmiPrinter.printCustom(
          "Card name : "+data[i]['card_name'], 1,0);
        SunmiPrinter.printCustom(
          "Catogery : "+data[i]['category_name'], 1,0);

        SunmiPrinter.printCustom(
          "MRP : "+data[i]['MRP'], 1,0);

        SunmiPrinter.printCustom(
          "Card Count : "+data[i]['card_count'], 1,0);
        SunmiPrinter.printCustom(
          "Transaction ID : "+data[i]['trans_id'], 1,0);
        SunmiPrinter.printCustom(
          "Date : "+data[i]['sold_on'], 1,0);



        SunmiPrinter.printNewLine();


      }

      SunmiPrinter.printNewLine();
      //
      //
      //
      SunmiPrinter.printCustom("------------------------",1,1);

      SunmiPrinter.printCustom('Thank You', 1,1);
      SunmiPrinter.printCustom('www.pluspays.in', 1,1);
      SunmiPrinter.printCustom("------------------------",1,1);


      //
      SunmiPrinter.printNewLine();
      SunmiPrinter.printNewLine();




      showToast("Print Completed");


    }else{
      showToast("No Devices Connected!");
    }
  });


  return "OK";
}