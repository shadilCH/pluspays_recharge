import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pluspay/Api/RechargeApi.dart';
import 'package:pluspay/Api/VoucherRechargeApi.dart';
import 'package:pluspay/Api/planInfoApi.dart';
import 'package:pluspay/Const/Constants.dart';
import 'package:pluspay/Const/sharedPref.dart';
import 'package:pluspay/Const/snackbar_toast_helper.dart';
import 'package:pluspay/SubScreens/PaymentSuccess.dart';
import 'package:pluspay/SubScreens/PrintPage.dart';

import '../main.dart';

class RechargeNow extends StatefulWidget {
  final id;
  final type;
  final num;
  final service;

  const RechargeNow({ key, this.id, this.type,this.num,this.service}) : super(key: key);

  @override
  _RechargeNowState createState() => _RechargeNowState();
}

class _RechargeNowState extends State<RechargeNow> {
  var arrProdList = [];
  var arrBannerList = [];
  var isLoading = true;
  var isTap = false;
  var ProviderLogo;
  var ProviderCode;
  var ProviderName;
  var DialInfo;
  var SkuCode;
  var CoupenTitle;
  var SendValue;
  var SendCurrencyIso;
  var OurCommission;
  var Our_SendValue;
  var ReceiveValue;
  var ReceiveCurrencyIso;

  TextEditingController accController = TextEditingController();
  var dash = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("xoxoxo");
    this.getHome();

    setState(() {

      if(widget.num!=null){
        accController.text=widget.num.toString();
      }
    });
  }

  Future<String> getHome() async {
    var ds = await getSharedPrefrence("dash");
    setState(() {
      dash = ds;
    });

    print("rechaaaaarge");
    print(widget.id);
    var rsp = await planInfoApi(widget.id);
    print("rechaaaaarge");
    print(rsp);

    if (rsp != 0 && rsp['status'] == true) {
      setState(() {
        ProviderLogo = rsp['provider_info']['ProviderLogo'].toString();
        ProviderCode = rsp['provider_info']['ProviderCode'].toString();
        ProviderName = rsp['provider_info']['ProviderName'].toString();
        DialInfo = rsp['provider_info']['DialInfo'].toString();

        SkuCode = rsp['plan_info'][0]['SkuCode'].toString();
        CoupenTitle = rsp['plan_info'][0]['CoupenTitle'].toString();
        SendValue = rsp['plan_info'][0]['SendValue'].toString();
        SendCurrencyIso = rsp['plan_info'][0]['SendCurrencyIso'].toString();
        OurCommission = rsp['plan_info'][0]['OurCommission'].toString();
        Our_SendValue = rsp['plan_info'][0]['Our_SendValue'].toString();
        ReceiveValue = rsp['plan_info'][0]['ReceiveValue'].toString();
        ReceiveCurrencyIso =
            rsp['plan_info'][0]['ReceiveCurrencyIso'].toString();
      });
    }

    setState(() {
      isLoading = false;
    });

    return " ";
  }

  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: isLoading == true
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        height: ss.height * 0.2,
                        width: ss.width * 0.2,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: (Colors.grey.shade300),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 3),
                              ),
                            ],
                            image: DecorationImage(
                              image: NetworkImage(ProviderLogo, scale: 2.5),
                            ),
                            border: Border.all(color: Colors.black12),
                            shape: BoxShape.circle),
                      ),
                    ),
                    C1(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    txtField(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Button(),
                  ],
                ),
              ),
            ),
    );
  }

  C1() {
    final ss = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.32,
        ),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Card(
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey.shade300),
                // boxShadow: [
                //   BoxShadow(
                //     color: (Colors.grey[200])!,
                //     spreadRadius: 1,
                //     blurRadius: 3,
                //     offset: Offset(5, 5),
                //   ),
                // ],
                color: Colors.grey[200],
              ),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Stack(
                children: [
                  Positioned(
                    bottom: width*0.02,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              CoupenTitle,
                              style: TextStyle(
                                  color: dash == "1" ? themePink : themeBlue,
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                 dash=="1"? Positioned(
                    top: width*0.04,
                    right: width*0.06,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: Colors.grey.shade300)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: ss.width * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              SendCurrencyIso,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ss.height * 0.03,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              Our_SendValue,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ss.height * 0.03,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ):Container(),
                ],
              ),
            ),
          ),
        ),

        Positioned(

          child: Text(
            ProviderName,
            style: TextStyle(
                color: dash == "1" ? themePink : themeBlue,
                fontSize: width * 0.045,
                fontWeight: FontWeight.bold),
          ),
          top: 0,
          right: 8,
          left: ss.width * 0.22,
        ),
        Positioned(
          top: width*0.18,
          left: width*0.06,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: dash == "1" ? themePink : themeBlue),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ReceiveCurrencyIso,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.06,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        dash=="1"?ReceiveValue:Our_SendValue,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.08,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget txtField() {
    final ss = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border:
              Border.all(color: dash == "1" ? themePink : themeBlue, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
        ),
        child: TextFormField(
          cursorColor: Colors.black,
          controller: accController,
          autofocus: false,
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontSize: ss.height * 0.028,
            letterSpacing: 0.8,
            fontWeight: FontWeight.w600,
          ),
          decoration: new InputDecoration(
            // prefixText: "+91",
            border: InputBorder.none,
            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            hintStyle: TextStyle(
                fontSize: ss.height * 0.025,
                fontWeight: FontWeight.w500,
                color: dash == "1" ? themePink : themeBlue),
            hintText: "Mobile number",
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Button() {
    final ss = MediaQuery.of(context).size;

    return isTap == true
        ? Container(
            height: 50,
            child: Center(child: CircularProgressIndicator()),
          )
        : GestureDetector(
            onTap: () async {

              setState(() {
                isTap = true;
              });
              if (accController.text.isNotEmpty) {
                var rsp;
                if(widget.service=="DigitalProduct"){
                  rsp= await VoucherRechargeApi(
                      ProviderCode,
                      accController.text.toString(),
                      Our_SendValue,
                      SkuCode,
                      ReceiveValue,
                      CoupenTitle,
                      "1",SendValue,false,null);
                }else{
                  rsp= await RechargeApi(
                      ProviderCode,
                      accController.text.toString(),
                      Our_SendValue,
                      SkuCode,
                      ReceiveValue,
                      CoupenTitle,
                      "1",SendValue,false,null);
                }

                if (rsp != 0 &&  rsp['status'].toString() == "true") {

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => PaymentSuccess()),
                  // );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Print(id: rsp['transaction_id'].toString())),);
                  showToast(rsp['message'].toString());
                } else {
                  showToast(rsp['message'].toString());
                }
              } else {
                showToast("Invalid Mobile Number!");
              }

              setState(() {
                isTap = false;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: dash == "1" ? themePink : themeBlue,
                  boxShadow: [
                    BoxShadow(
                      color: (Colors.grey.shade300),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    'Recharge Now'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ss.height * 0.03,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          );
  }
}
