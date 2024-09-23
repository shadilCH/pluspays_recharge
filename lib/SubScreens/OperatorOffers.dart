import 'package:flutter/material.dart';
import 'package:pluspay/Api/RechargeApi.dart';
import 'package:pluspay/Api/customRcHomeData.dart';
import 'package:pluspay/Api/plansByProviderApi.dart';
import 'package:pluspay/Const/Constants.dart';
import 'package:pluspay/Const/resources.dart';
import 'package:pluspay/Const/sharedPref.dart';
import 'package:pluspay/Const/snackbar_toast_helper.dart';
import 'package:pluspay/SubScreens/PrintPage.dart';

import '../main.dart';
import 'RechargeNow.dart';

class OperatorOffers extends StatefulWidget {
  final id;
  final type;
  final service;
  const OperatorOffers({ key, this.id, this.type,this.service}) : super(key: key);

  @override
  _OperatorOffersState createState() => _OperatorOffersState();
}

class _OperatorOffersState extends State<OperatorOffers> {
  var isLoading = true;
  var showCustom = false;
  var arrList = [];
  var arrDetails;
  var dash = "0";
  var custom = "0";



  TextEditingController numController = TextEditingController();


  TextEditingController amntController = TextEditingController();


  var customTap = false;
  var isTap = false;
  var isAmnt = false;
  var rechargeStart = false;




  var ProviderLogo;

  var ProviderName;
  var MaximumAmount;
  var MinimumAmount;
  var ReceivableAmount;
  var SkuCode;


  var ProviderCode;

  var Our_SendValue;
  var SendValue;

  var ReceiveValue;
  var CoupenTitle;
  var  type;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("xoxoxo");
    print(widget.id);
    this.getHome();

    setState(() {});
  }

  Future<String> getHome() async {
    var ds = await getSharedPrefrence("dash");
    setState(() {
      dash = ds;
    });
    var rsp = await plansByProviderApi(widget.id.toString());
    //
    print("providersssss");
    print(rsp);
    if (rsp ['status']!= false ) {
      setState(() {
        arrList = rsp['products']['PlanInfo'];
        arrDetails = rsp['products']['ProviderInfo'];

        showCustom = rsp['products']['PlanInfo'][0]['range'];

      });
    }

    print("catogerrrrry");
    print(arrDetails);

    setState(() {
      isLoading = false;
    });

    return " ";
  }
  Future<String> getCustom() async {

    setState(() {
      customTap=true;
    });
    var rsp = await customHomeRcData(numController.text.toString(), amntController.text.toString());
    print("rspppppppppp");
    print(rsp);
    if( rsp['status']==true){

      setState(() {
        MaximumAmount = rsp['DenominationInfo']['Maximum Amount'].toString();
        MinimumAmount = rsp['DenominationInfo']['Minimum Amount'].toString();
        ReceivableAmount = rsp['DenominationInfo']['ReceivableAmount'].toString();

        ProviderName = rsp['DenominationInfo']['ProviderName'].toString();
        SkuCode = rsp['DenominationInfo']['SkuCode'].toString();
        ProviderCode = rsp['DenominationInfo']['ProviderCode'].toString();
        Our_SendValue = rsp['DenominationInfo']['Our_SendValue'].toString();
        ReceiveValue = rsp['DenominationInfo']['ReceiveValue'].toString();
        SendValue = rsp['DenominationInfo']['SendValue'].toString();
        CoupenTitle = rsp['DenominationInfo']['ReceivableAmount'].toString();
        type = rsp['DenominationInfo']['type'].toString();



      });
      CertificatePopUp();

    }else{
      showToast(rsp.toString());
    }
    setState(() {
      customTap=false;
    });
    return "";
  }
  void CertificatePopUp() {
    showDialog(
      context: context,
      builder: (context) {

        return StatefulBuilder(
          builder: (context, setState) {
            return  AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 16),
              shape:
              RoundedRectangleBorder(borderRadius: new BorderRadius.circular(24)),
              scrollable: false,
              elevation: 10,
              content: StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/walleticon.png",
                                width: 49,
// height: ,
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Note',
                                      textAlign: TextAlign.left,
                                      style: bold14,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                        "Provider Name : "+ProviderName +"\n"+
                                            "Maximum Amount : "+MaximumAmount +"\n"+
                                            "Minimum Amount : "+MinimumAmount +"\n"+
                                            "Receivable Amount : "+ReceivableAmount ,
                                        style: size14_400G
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
// Navigator.push(
//   context,
//   MaterialPageRoute(
//       builder: (context) => CertificatePasscode()),
// );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red.shade400),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Text(
                                      "Dismiss",
                                      style: txt14SemiWhite,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              GestureDetector(
                                onTap: () async{

                                  setState(() {

                                    rechargeStart = true;
                                  });
                                  var rsp = await RechargeApi(
                                      ProviderCode,
                                      numController.text.toString(),
                                      Our_SendValue,
                                      SkuCode,
                                      ReceiveValue,
                                      CoupenTitle,
                                      type,SendValue,showCustom,amntController.text);

                                  Navigator.pop(context);

                                  if (rsp != 0 &&  rsp['status'].toString() == "true") {

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => Print(id: rsp['transaction_id'].toString())),);
                                    showToast(rsp['message'].toString());
                                  } else {
                                    showToast(rsp['message'].toString());
                                  }
                                  setState(() {

                                    rechargeStart = false;
                                  });

                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: themeBlue),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: rechargeStart==false?Text(
                                      "Recharge",
                                      style: txt14SemiWhite,
                                    ):Container(height:20,width:20,child: CircularProgressIndicator(backgroundColor: Colors.white,)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            );
          },
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Available Offer",
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5),
        ),
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
          : Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: width*0.05,),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: ss.width * 0.05),
                          child: Text(
                            arrDetails != null
                                ? arrDetails['ProviderName'].toString()
                                : "",
                            style: TextStyle(
                                color: dash == "1" ? themePink : themeBlue,
                                fontSize: ss.height * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        height: ss.height * 0.17,
                        width: ss.width * 0.17,

                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  arrDetails != null
                                      ? arrDetails['ProviderLogo'].toString()
                                      : "",
                                  scale: 3),
                            ),
                            border: Border.all(color: Colors.black12),
                            shape: BoxShape.circle),
                        // child: Image.network(
                        //   arrDetails != null
                        //       ? arrDetails['ProviderLogo'].toString()
                        //       : "",
                        //   height: ss.height * 0.065,
                        // ),
                      ),
                      SizedBox(
                        width: width * 0.09,
                      ),
                    ],
                  ),

                  showCustom==true?enterNum():Container(),
                  showCustom==true?txtBox2():Container(),
                  showCustom==false? Expanded(
                    child: Scrollbar(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15,
                          ),
                          shrinkWrap: true,
                          itemCount: arrList != null ? arrList.length : 0,
                          itemBuilder: (context, index) {
                            final item =
                            arrList != null ? arrList[index] : null;
                            return list(item, index);
                          },
                        ),
                      ),
                    ),
                  ):Container(),

                ],
              ),
            ),
    );
  }

  list(var item, int index) {
    final ss = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RechargeNow(
                    id: item['SkuCode'].toString(),
                    type: widget.type,
                    service: widget.service,

                  )),
        );
      },
      child: Card(
        elevation: 5,
        child: Container(
          color: Colors.grey[200],
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: ss.height * 0.13,
                  color: dash == "1" ? themePink : themeBlue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['ReceiveCurrencyIso'].toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ss.height * 0.03,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        dash=="0"?item['Our_SendValue'].toString():item['ReceiveValue'].toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ss.height * 0.032,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: ss.height * 0.13,
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dash=="0"?item['Our_SendValue'].toString():item['ReceiveValue'].toString(),
                          style: TextStyle(
                              color: dash == "1" ? themePink : themeBlue,
                              fontSize: ss.height * 0.03,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          item['CoupenTitle'].toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              color: dash == "1" ? themePink : themeBlue,
                              fontSize: ss.height * 0.02,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                         "Expiry Date : "+ item['Expiry_Date'].toString(),
                          style: TextStyle(
                              color: dash == "1" ? themePink : themeBlue,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              dash == "1" ? Container(
                height: MediaQuery.of(context).size.height * 0.1,
                color: Colors.black12,
                width: 2,
              ):Container(),
              dash == "1" ? Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  color: Colors.grey[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['SendCurrencyIso'].toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: ss.height * 0.03,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        item['Our_SendValue'].toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: ss.height * 0.03,
                            fontWeight: FontWeight.w600),
                      ),
                      // Text(
                      //   item['Expiry_Date'].toString(),
                      //   style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: ss.height * 0.03,
                      //       fontWeight: FontWeight.w600),
                      // ),
                    ],
                  ),
                ),
              ):Container(),
            ],
          ),
        ),
      ),
    );
  }

  txtBox2() {
    final ss = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 10,right: 10,left: 10),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                height: ss.height * 0.06,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    border: Border.all(color: Colors.black12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: TextFormField(
                    controller: amntController,
                    cursorColor: Colors.black,
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: ss.height * 0.026,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: width*0.021),
                      prefixIconConstraints:
                      BoxConstraints(minWidth: 0, minHeight: 0),
                      hintStyle: TextStyle(
                          fontSize: ss.height * 0.02,
                          fontWeight: FontWeight.w400,
                          color: Colors.black45),
                      hintText: "Recharge Amount",
                      errorText: isAmnt == true ? 'This cant be empty' : null,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {

                // CertificatePopUp();
                // return;
                setState(() {
                  isTap = false;
                  isAmnt = false;
                });

                if (numController.text.isEmpty) {
                  setState(() {
                    isTap = true;
                  });

                  return;
                }

                if (amntController.text.isEmpty) {
                  setState(() {
                    isAmnt = true;
                  });
                  return;
                }
                // pushNewScreen(
                //   context,
                //   screen: ConfirmRechargeCustom(
                //     id: widget,
                //     amt: amntController.text.toString(),
                //     num: numController.text.toString(),
                //   ),
                //   withNavBar: false, // OPTIONAL VALUE. True by default.
                //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                // );
                FocusManager.instance.primaryFocus?.unfocus();
                getCustom();
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child:Container(
                  alignment: Alignment.center,
                  height: ss.height * 0.06,
                  child: customTap==false?Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Recharge Now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: ss.height * 0.02),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: ss.height * 0.025,
                      )
                    ],
                  ):CircularProgressIndicator(),
                  decoration: BoxDecoration(
                      color: themePink,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10))),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  enterNum(){
    final ss = MediaQuery.of(context).size;

    return Container(
      child:  Row(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                height: ss.height * 0.06,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    border: Border.all(color: Colors.black12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: TextFormField(
                    controller: numController,
                    cursorColor: Colors.black,
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: ss.height * 0.026,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      prefixIconConstraints:
                      BoxConstraints(minWidth: 0, minHeight: 0),
                      hintStyle: TextStyle(
                          fontSize: ss.height * 0.02,
                          fontWeight: FontWeight.w300,
                          color: Colors.black45),
                      contentPadding: EdgeInsets.only(bottom:width*0.02),
                      hintText: "Mobile Number",
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
             //   getHome(numController.text.toString(),"top_up");
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  height: ss.height * 0.06,
                  child: Icon(
                    Icons.mobile_friendly,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      color: dash == "1" ? themePink : themeBlue,
                      border: Border.all(color: Colors.black12),

                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10))),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
