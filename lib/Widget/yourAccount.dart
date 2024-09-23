import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pluspay/Api/RechargeApi.dart';
import 'package:pluspay/Api/customRcHomeData.dart';
import 'package:pluspay/Api/plansByNumberApi.dart';
import 'package:pluspay/Const/Constants.dart';
import 'package:pluspay/Const/resources.dart';
import 'package:pluspay/Const/sharedPref.dart';
import 'package:pluspay/Const/snackbar_toast_helper.dart';
import 'package:pluspay/SubScreens/PaymentSuccess.dart';
import 'package:pluspay/SubScreens/PrintPage.dart';
import 'package:pluspay/SubScreens/RechargeNow.dart';

import '../main.dart';

class YourAccount extends StatefulWidget {
  final code;
  const YourAccount({key, this.code}) : super(key: key);

  @override
  _YourAccountState createState() => _YourAccountState();
}

class _YourAccountState extends State<YourAccount> {
  var dash = "0";
  var isLoading = true;
  var rechargeStart = false;
  var arrList = [];
  TextEditingController numController = TextEditingController();


  TextEditingController amntController = TextEditingController();

  var showCustom = false;
  var customTap = false;
  var isTap = false;
  var isAmnt = false;

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
var code;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("xoxoxo");
    this.getColor();
    code= widget.code;
    setState(() {
      // if (widget.code != null) {
      //   numController.text = widget.code;
      // }
    });
  }

  Future<String> getColor() async {
    var name = await getSharedPrefrence("dash");

    setState(() {
      dash = name;
      isLoading = false;
    });
    return "";
  }

  Future<String> getHome(num,type) async {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      isLoading = true;
    });

    var rsp = await plansByNumberApi(num.toString(), type);

    print("responsee");
    print(rsp);
    if (rsp != 0 && rsp['status'] == true) {
      setState(() {
        arrList = rsp['plans'];
        showCustom = rsp['plans'][0]['range'];
        ProviderLogo = rsp['provider_info']['ProviderLogo'].toString();
        ProviderName = rsp['provider_info']['ProviderName'].toString();

      });
    }
    print("arrList");
    print(arrList);
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
        CoupenTitle = rsp['DenominationInfo']['ReceivableAmount'].toString();
        SendValue = rsp['DenominationInfo']['SendValue'].toString();
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


                                  if (rsp != 0 && rsp['status'].toString() == "true") {
                                    print("yessssssss");
                                    Navigator.pop(context);

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => Print(id: rsp['transaction_id'].toString())),);
                                    showToast(rsp.toString());
                                  } else {
                                    print("nottttt");
                                    showToast(rsp.toString());
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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            )),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      height: ss.height * 0.06,
                      decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              topLeft: Radius.circular(25)),
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding:  EdgeInsets.only(left: width*0.03),
                        child: TextFormField(
                          controller: numController,
                          cursorColor: Colors.black,
                          autofocus: false,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: width * 0.04,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: width*0.01),
                            // prefixIconConstraints:
                            //     BoxConstraints(minWidth: 0, minHeight: 0),
                            prefix: InkWell(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode: true, // optional. Shows phone code before the country name.
                                  onSelect: (Country country) {
                                    setState(() {

                                      code =country.phoneCode.toString();

                                    });
                                    print('Select country: ${country.flagEmoji}');
                                  },
                                );
                              },
                              child: Container(

                                width: width*0.12,
                                child: Center(child: Text("+"+code,style: TextStyle(fontSize: width*0.04,),)),

                              ),
                            ),
                            hintStyle: TextStyle(
                                fontSize: ss.height * 0.02,
                                fontWeight: FontWeight.w300,
                                color: Colors.black45),
                            hintText: " Mobile Number",
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
                      getHome(code+numController.text.toString(),"top_up");
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        height: ss.height * 0.06,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            color: dash == "1" ? themePink : themeBlue,
                            border: Border.all(color: Colors.black12),
                            boxShadow: [
                              BoxShadow(
                                color: (Colors.grey.shade300),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 1),
                              ),
                            ],
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
                                topRight: Radius.circular(25))),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: ss.height * 0.02,
            ),
            arrList.isNotEmpty?operatorInfo():Container(),
            arrList.isNotEmpty?SizedBox(
              height: ss.height * 0.02,
            ):Container(),

            showCustom==true?txtBox2():Container(),

            showCustom==false?Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                box("TopUp", () {
                  getHome(code+numController.text.toString(),"top_up");

                }),
                box("Data", () {
                  getHome(code+numController.text.toString(),"data");
                }),
                box("Combo", () {
                  getHome(code+numController.text.toString(),"combo");
                })
              ],
            ):Container(),
            isLoading == true
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    // width: MediaQuery.of(context).size.width,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : showCustom==true?Container(): Flexible(
                    child: Container(
                      child: Scrollbar(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10,
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
                    ),
                  ),
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
                    type: "1",
                    num: numController.text.toString(),
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
                      FittedBox(
                        child: Text(
                          dash == "0"
                              ? item['Our_SendValue'].toString()
                              : item['ReceiveValue'].toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ss.height * 0.04,
                              fontWeight: FontWeight.w600),
                        ),
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
                          dash == "0"
                              ? item['Our_SendValue'].toString()
                              : item['ReceiveValue'].toString(),
                          style: TextStyle(
                              color: dash == "1" ? themePink : themeBlue,
                              fontSize: ss.height * 0.032,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          item['CoupenTitle'].toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              color: dash == "1" ? themePink : themeBlue,
                              fontSize: ss.height * 0.022,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Expiry Date : "+ item['Expiry_Date'].toString(),
                          style: TextStyle(
                              color: dash == "1" ? themePink : themeBlue,
                              fontSize: width*0.03,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              dash == "1"
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      color: Colors.black12,
                      width: 2,
                    )
                  : Container(),
              dash == "1"
                  ? Expanded(
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
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  box(String txt, GestureTapCallback onTapp) {
    return GestureDetector(
      onTap: onTapp,
      child: Card(
        // elevation: 5,
        color:  dash == "1" ? themePink : themeBlue,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Text(
            txt,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.height * 0.023),
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
                height: ss.height * 0.08,

                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: (Colors.grey.shade300),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
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
                      prefixIconConstraints:
                      BoxConstraints(minWidth: 0, minHeight: 0),
                      hintStyle: TextStyle(
                          fontSize: ss.height * 0.021,
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
                  height: ss.height * 0.08,
                  child: customTap==false?Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Recharge Now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: ss.height * 0.023),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: ss.height * 0.025,
                      )
                    ],
                  ):CircularProgressIndicator(),
                  decoration: BoxDecoration(
                      gradient: grad,
                      border: Border.all(color: Colors.black12),
                      boxShadow: [
                        BoxShadow(
                          color: (Colors.grey.shade300),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
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


  operatorInfo() {
    final ss = MediaQuery.of(context).size;

    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, bottom: 10),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: (Colors.grey.shade300),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                ),
              ],
              border: Border.all(color: Colors.black12),
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image(
              image: NetworkImage(ProviderLogo != null ? ProviderLogo : "",
                  scale: 2),
              height: 100,
            ),
          ),
          height: 70,
          width: 70,
        ),
        SizedBox(
          width: ss.width * 0.04,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ProviderLogo != null ? ProviderName : "",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue),
              ),
              // Text(
              //   "Prepaid",
              //   style: TextStyle(
              //       fontSize: ss.height * 0.025,
              //       fontWeight: FontWeight.w600,
              //       color: Colors.blue),
              // ),
            ],
          ),
        )
      ],
    );
  }
}
