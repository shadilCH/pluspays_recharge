import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'dart:typed_data';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/material.dart';
import 'package:maxx_sunmi_printer/maxx_sunmi_printer.dart';
import 'package:pluspay/Api/rechargeInfoApi.dart';

import 'package:pluspay/Const/Constants.dart';
import 'package:pluspay/Const/resizeImg.dart';
import 'package:pluspay/Const/sharedPref.dart';
import 'package:pluspay/Const/snackbar_toast_helper.dart';
import 'package:pluspay/Convert/util8convert.dart';
import 'package:pluspay/Screens/BluethoothNewTestPrint.dart';

import 'package:screenshot/screenshot.dart';
import 'package:flutter/services.dart';
import 'package:pluspay/Const/network.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';

class Print extends StatefulWidget {

  final id;
  final cid;

  Print({this.id,this.cid});
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Print> {

  ScreenshotController screenshotController = ScreenshotController();
   late Uint8List _imageFile;
  BluetoothManager bluetoothManager = BluetoothManager.instance;


  var  isLoading = true;
  var name ;
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


  var nowDate ="";
  var nowTime ="";
  var recharge_info ="";
  var voucher_info ="";

  var isTap =false;
  DateTime now = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    print("orderid");
    print(widget.id);

    this.getHome();
  //  this.bluetoothSearch();


  }

  Future<String> getHome() async {

   // name = await getSharedPrefrence("name");

    var rsp = await rechargeInfoApi(widget.id.toString());
    print("saleid");
    print(rsp);
    //0
    if(rsp['status']==true){


      setState(() {
        TransactionID =rsp['recharge_info']['TransactionID'].toString();
        AccountNumber =rsp['recharge_info']['AccountNumber'].toString();
        recharge_amount =rsp['recharge_info']['recharge_amount'].toString();
        provider_name =rsp['recharge_info']['provider_name'].toString();
        CountryName =rsp['recharge_info']['CountryName'].toString();
        RechargedTime =rsp['recharge_info']['date_time'].toString();
        shop_name =rsp['recharge_info']['shop_name'].toString();

        coupen_info =rsp['recharge_info']['coupen_info'].toString();
        location =rsp['recharge_info']['location'].toString();
        RechargeType = rsp['recharge_info']['RechargeType'].toString() ;
        RechargeID =rsp['recharge_info']['RechargeID'].toString();





        nowDate =DateTime.now().year.toString()+"-"+ DateTime.now().month.toString()+"-"+ DateTime.now().day.toString();
        nowTime =now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString();

        recharge_info =rsp['recharge_info']['recharge_info'].toString();
        voucher_info =rsp['recharge_info']['voucher_info'].toString();
      });
    }

    print("ingatuuuuu");
    print(rsp);
    setState(() {
      isLoading = false;
    });

    return "";
  }





    void capture(){
      screenshotController
          .capture(delay: Duration(milliseconds: 10)).then(
              (Uint8List? image) async {
            if (image != null) {
              await Share.file('Plex Pay Recharge', 'card.jpg', image, 'image/jpg');
              setState(() {
                _imageFile = image;
              });
            }

          }
      )
          .catchError((onError) {
        print(onError);
      });
    }


  void bluetoothSearch(){
    if (Platform.isAndroid) {
      bluetoothManager.state.listen((val) {
        print('state = $val');
        if (!mounted) return;
        if (val == 12) {
          print('on');

          print('off');


        }else{
          showToastError("Please Enable your Bluetooth!");
        }
      });
    } else {

    }

    setState(() {
      isLoading = false;
    });
  }

  Future<Uint8List> networkImageToByte(String imageUrl) async {
    final ByteData imageData = await NetworkAssetBundle(Uri.parse(imageUrl)).load("");
    final Uint8List bytes = imageData.buffer.asUint8List();
    return bytes;
  }







  void printOut2()async{

    /// logo

    Uint8List byteImage1 = await networkImageToByte(pluspayImgUrl);
    final imgData1 = base64.encode(byteImage1);
    // var convrt = await imgConvert(byteImage1);

    MaxxSunmiPrinter.printImage(imgData1);

    //SunmiPrinter.emptyLines(1);
    /// url

    MaxxSunmiPrinter.printText("www.plexpays.in",
        styles: SunmiStyles(alignment: SunmiAlign.center,isBold: true));

    ///   barcode
    Uint8List byteImage = await networkImageToByte(barcodImgUrl);


    final imgData = base64.encode(byteImage);
    MaxxSunmiPrinter.printImage(imgData);
    //   SunmiPrinter.hr();

    ///  now date
    MaxxSunmiPrinter.printText(DateTime.now().toString(),
        styles: SunmiStyles(alignment: SunmiAlign.center,isBold: true));


    ///datas ->







    MaxxSunmiPrinter.printText(
      "RECEIPT NO    :  "+DateTime.now().millisecond.toString(),
      styles: SunmiStyles(alignment: SunmiAlign.left,isBold: true),
    );
    if( shop_name.toString()!="null"){
      MaxxSunmiPrinter.printText(
        "SHOP NAME    :  "+name.toString(),
        styles: SunmiStyles(alignment: SunmiAlign.left,isBold: true),
      );

    }
    if( TransactionID.toString()!="null"){
      MaxxSunmiPrinter.printText(
        "RECHARGE ID   :  "+TransactionID.toString(),
        styles: SunmiStyles(alignment: SunmiAlign.left,isBold: true),
      );


    }
    if( RechargeID.toString()!="null"){
      MaxxSunmiPrinter.printText(
        "RECHARGE ID      :  "+RechargeID.toString(),
        styles: SunmiStyles(alignment: SunmiAlign.left,isBold: true),
      );

    }
    if( coupen_info.toString()!="null"){
      MaxxSunmiPrinter.printText(
        "COUPON INFO      :  "+coupen_info.toString(),
        styles: SunmiStyles(alignment: SunmiAlign.left,isBold: true),
      );

    }


    if( provider_name.toString()!="null"){
      MaxxSunmiPrinter.printText(
        "PROVIDER NAME      :  "+provider_name.toString(),
        styles: SunmiStyles(alignment: SunmiAlign.left,isBold: true),
      );

    }

    if( recharge_info.toString()!="null"){
      MaxxSunmiPrinter.printText(
        "RECHARGE INFO      :  "+recharge_info.toString(),
        styles: SunmiStyles(alignment: SunmiAlign.left,isBold: true),
      );

    }
    if( voucher_info.toString()!="null"){
      MaxxSunmiPrinter.printText(
        "VOUCHER INFO      :  "+voucher_info.toString(),
        styles: SunmiStyles(alignment: SunmiAlign.left,isBold: true),
      );

    }
    if( location.toString()!="null"){
      MaxxSunmiPrinter.printText(
        "LOCATION      :  "+location.toString(),
        styles: SunmiStyles(alignment: SunmiAlign.left,isBold: true),
      );

    }
    if( AccountNumber.toString()!="null"){
      MaxxSunmiPrinter.printText(
        "MOBILE NUMBER :  "+AccountNumber.toString(),
        styles: SunmiStyles(alignment: SunmiAlign.left,isBold: true),
      );

    }
    if( RechargeType.toString()!="null"){
      MaxxSunmiPrinter.printText(
        "TYPE          :  "+RechargeType.toString(),
        styles: SunmiStyles(alignment: SunmiAlign.left,isBold: true),
      );

    }

    if( recharge_amount.toString()!="null"){
      MaxxSunmiPrinter.printText(
        "AMOUNT        :  "+recharge_amount.toString(),
        styles: SunmiStyles(alignment: SunmiAlign.left,isBold: true),
      );

    }


    if( RechargedTime.toString()!="null"){
      MaxxSunmiPrinter.printText(
        "DATE & TIME   :  "+RechargedTime.toString(),
        styles: SunmiStyles(alignment: SunmiAlign.left,isBold: true),
      );

    }





    MaxxSunmiPrinter.printText(
      "STATUS        :  "+"SUCCESS",
      styles: SunmiStyles(alignment: SunmiAlign.left,isBold: true),
    );



    setState(() {
      isTap=false;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50]?.withOpacity(0.99),

      body: isLoading==true?Container(

        child: Center(child: CircularProgressIndicator())
        ,
      ): SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 10,bottom: 10),
              color: Colors.white,
              child: Screenshot(
                controller: screenshotController,
                child: Container(

                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/aiims-f0413.appspot.com/o/PLUS%20PAY%20RECHARGE%20LOGO.png?alt=media&token=9d01deb3-d52f-4cbe-ab1a-a22b274f2ae4"),
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                          Text("www.pluspays.in"),
                          Image(
                            image: NetworkImage(
                                barcodeImgUrl),
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                         // Text(sold_on),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Wrap(
                                runSpacing: 10,
                                children: [

                                  DetailsB("SHOP NAME", shop_name.toUpperCase()),
                                  Details("TRANSACTION ID", TransactionID.toUpperCase()),
                                  Details("RECHARGE ID", RechargeID.toUpperCase()),
                                  Details("COUPON INFO", coupen_info.toUpperCase()),
                                  Details("VOUCHER INFO", voucher_info.toUpperCase()),
                                  Details("RECHARGE INFO", recharge_info.toUpperCase()),
                                  Details("OPERATOR", provider_name.toUpperCase()),
                                  Details("LOCATION", location.toUpperCase()),
                                  Details("MOBILE NUMBER", AccountNumber.toUpperCase()),
                                  Details("TYPE", RechargeType.toUpperCase()),
                                  Details("AMOUNT", recharge_amount.toUpperCase()),


                                  Details("DATE & TIME", RechargedTime.toUpperCase()),
                                  Details("STATUS", "success".toUpperCase()),

                                ],
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          // Text(
                          //   "WhatsApp Support: " + "0578914789",
                          //   style: TextStyle(fontWeight: FontWeight.bold),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 40,
        child: Row(
          children: [
            Expanded(child: Button1("Sunmi Print")),
            Container(
              height: 50,
              width: 2,
              color: Colors.white,
            ),
            Expanded(child: Button3("BT Print")),
            Container(
              height: 50,
              width: 2,
              color: Colors.white,
            ),
            Expanded(child: Button2("Share"))
          ],
        ),
      ),
    );
  }

  Widget Details(String label1, String label2) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Expanded(
            child: Text(
              label1.toUpperCase(),
            )),
        Text(":  "),
        Expanded(
            child: Text(
              label2.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
  Widget DetailsB(String label1, String label2) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
     // mainAxisAlignment:MainAxisAlignment.start,
     children: [
        Expanded(
            child: Text(
              label1.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        Text(":  "),
        Expanded(
            child: Text(
              label2.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
      ],
    );
  }

  Widget Button1(String label) {
    return GestureDetector(
      onTap:isTap==true?null:(){
        setState(() {
          isTap=true;
        });
      printOut2();
      } ,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        child: Text(
          label,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        color:isTap==true?Colors.grey: Colors.indigo,
      ),
    );
  }
  Widget Button2(String label) {
    return GestureDetector(
      onTap:(){
        capture();
      } ,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        child: Text(
          label,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        color: Colors.indigo,
      ),
    );
  }
  Widget Button3(String label) {
    return GestureDetector(
      onTap:isTap==true?null:(){

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BtTestPt(data:widget.id)),
        );



      } ,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        child: Text(
          label,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        color: Colors.indigo,
      ),
    );
  }
}

final HeadingTxt = TextStyle(fontSize: 35, fontWeight: FontWeight.bold);
