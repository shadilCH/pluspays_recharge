import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:pluspay/Api/rechargeInfoApi.dart';
import 'package:pluspay/Const/snackbar_toast_helper.dart';
import 'package:pluspay/PrintHelper/TestPrint.dart';

import '../main.dart';






class BtTestPt extends StatefulWidget {

  final data;


  BtTestPt({this.data});
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<BtTestPt> {

  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  List<BluetoothDevice>? _devices;
  BluetoothDevice? _device;
  bool _connected = false;
  late String pathImage;
///
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

  var arrData;

  var isTap =false;
  DateTime now = DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    initPlatformState();
    this.getData();


  }
///api connection
  Future<String> getData() async {


   var rsp = await rechargeInfoApi(widget.data.toString());

    print("saleid");
    print(rsp);
    //0
    if(rsp['status']==true){

      setState(() {
        arrData=rsp;
      });

    }

    print("ingatuuuuu");
    print(rsp);
    setState(() {
      isLoading = false;
    });
    return "";
  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('Choose your device',style: TextStyle(
            fontSize: width*0.05,
            fontWeight: FontWeight.bold
          ),),
        ),
        body: isLoading==true?Container(

          child: Center(child: CircularProgressIndicator())
          ,
        ):Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 10,),
                    Text(
                      'Device:',
                      style: TextStyle(
                        fontSize: width*0.04,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 30,),
                    Expanded(
                      child: DropdownButton(
                        items: _getDeviceItems(),
                        onChanged: (BluetoothDevice? value) => setState(() => _device = value!),
                        value: _device,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: width*0.08,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap:(){
                        initPlatformState();
                      },
                      child: Container(
                          width: width*0.25,
                          height: width*0.08,

                          decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(width*0.03),
                            color: Colors.pink,
                          ),
                          child: Center(child: Text('Refresh', style: TextStyle(color: Colors.white,fontSize: width*0.035),))),
                    ),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap:
                      _connected ? _disconnect : _connect,
                      child: Container(
                        width: width*0.25,
                          height: width*0.08,
                          decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(width*0.03),
                            color: _connected ?Colors.red:Colors.green,
                          ),
                          child: Center(child: Text(
                            _connected ? 'Disconnect' : 'Connect', style: TextStyle(
                              color: Colors.white,
                            fontSize: width*0.035
                          ),))),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
                  child:  GestureDetector(
                    onTap:()async{
                      ///print here
                      customSnackBar(context,"Printing...",_scaffoldKey as int,6);
                      print("isTappppppp");
                      print(isTap);
                    var rsp = await getHome(arrData);


                    },
                    child: Container(
                      height: width*0.12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width*0.03),
                          color: Colors.pink,
                        ),

                        child: Center(child: Text(isTap==true?"Printing..":'Start Print', style: TextStyle(color: Colors.white)))),
                  ),
                ),
                SizedBox(
                  height: width*0.03,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child:  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: width*0.12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width*0.03),
                          color: Colors.pink,
                        ),

                        child: Center(child: Text("Cancel", style: TextStyle(color: Colors.white)))),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    bool? isConnected=await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      // TODO - Error
    }

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
          });
          break;
        default:
          print(state);
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if(isConnected!) {
      setState(() {
        _connected=true;
      });
    }
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    setState(() {
      isLoading = true;
    });
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices!.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devices?.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name!),
          value: device,
        ));
      });
    }
    setState(() {
      isLoading = false;
    });
    return items;
  }


  void _connect() {
    if (_device == null) {
      show('No device selected.');
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (isConnected!) {
          bluetooth.connect(_device!).catchError((error) {
            setState(() => _connected = false);
          });
          setState(() => _connected = true);
        }
      });
    }
  }


  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _connected = true);
  }

//write to app path
//write to app path
  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future show(
      String message, {
        Duration duration: const Duration(seconds: 3),
      }) async {
    await new Future.delayed(new Duration(milliseconds: 100));

    showToast(message);
    // Scaffold.of(context).showSnackBar(
    //   new SnackBar(
    //     content: new Text(
    //       message,
    //       style: new TextStyle(
    //         color: Colors.white,
    //       ),
    //     ),
    //     duration: duration,
    //   ),
    // );
  }
}