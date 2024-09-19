import 'package:flutter/material.dart';
import 'package:pluspay/Api/walletAmnt.dart';
import 'package:pluspay/Const/Constants.dart';
import 'package:pluspay/Const/sharedPref.dart';
import 'package:pluspay/SubScreens/ElectricityBillPayment.dart';
import 'package:pluspay/SubScreens/OperatorSelect.dart';
import 'package:pluspay/Widget/yourAccount.dart';

class IndianTab extends StatefulWidget {
  final walletAmnt;
  final dueAmnt;

  // static const routeName = "/property-sell";

  const IndianTab({key, this.walletAmnt, this.dueAmnt}) : super(key: key);

  @override
  _IndianTabState createState() => _IndianTabState();
}

class _IndianTabState extends State<IndianTab> {
  var arrProdList = [];
  var arrBannerList = [];
  var isLoading = true;
  var wallet_amount;
  var due_amount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("xoxoxo");
    this.getHome();

    setState(() {});
  }

  Future<String> getHome() async {
    var name = await sharedPrefrence("dash", "0");

    var rsp = await walletAmnt();
    //
    print("catogerrrrry");
    print(rsp);
    if (rsp != 0) {
      setState(() {
        wallet_amount = rsp['wallet_amount'].toString();
        due_amount = rsp['due_amount'].toString();
      });
    }

    print("catogerrrrry");
    print(wallet_amount);
    setState(() {
      isLoading = false;
    });

    return " ";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Wrap(
        runSpacing: 20,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Balance_Due("Balance Amount", widget.walletAmnt),
              Balance_Due("Due Amount", widget.dueAmnt)
            ],
          ),
          txtField(),
          bottomRow(),
        ],
      )),
    );
  }

  Widget Balance_Due(String txt, String amount) {
    final ss = MediaQuery.of(context).size;

    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: themeBlue,
        boxShadow: [
          BoxShadow(
            color: (Colors.grey.shade400),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(2, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                txt,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ss.height * 0.03,
                    fontWeight: FontWeight.w300),
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                amount,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ss.height * 0.04,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget txtField() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => YourAccount(code: "91",)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: (Colors.grey.shade300),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ],
            border: Border.all(color: Colors.black12, width: 1)),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
          ),
          child: Row(
            children: [
              Text(
                "Mobile Number",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
              Spacer(),
              Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: themeBlue),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomRow() {
    final ss = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OperatorSelect(
                            service: "pin",
                            plan: "1",
                          )),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: themeBlue,
                  border: Border.all(color: Colors.black12),
                  boxShadow: [
                    BoxShadow(
                      color: (Colors.grey.shade400),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                height: 60,
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(
                    image: AssetImage("assets/Icons/prepaid.png"),
                    // fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "PREPAID",
              style: TextStyle(
                fontSize: ss.height * 0.02,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OperatorSelect(
                            service: "pin",
                            plan: "2",
                          )),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: themeBlue,
                  border: Border.all(color: Colors.black12),
                  boxShadow: [
                    BoxShadow(
                      color: (Colors.grey.shade400),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                height: 60,
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(
                    image: AssetImage("assets/Icons/postpaid.png"),
                    // fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "POSTPAID",
              style: TextStyle(
                fontSize: ss.height * 0.02,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OperatorSelect(id: "IN",service: "tv",),),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: themeBlue,
                  border: Border.all(color: Colors.black12),
                  boxShadow: [
                    BoxShadow(
                      color: (Colors.grey.shade400),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                height: 60,
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(
                    image: AssetImage("assets/Icons/dth.png"),
                    // fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "DTH",
              style: TextStyle(
                fontSize: ss.height * 0.02,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Newpayment()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: themeBlue,
                  border: Border.all(color: Colors.black12),
                  boxShadow: [
                    BoxShadow(
                      color: (Colors.grey.shade400),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                height: 60,
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(
                    image: AssetImage("assets/Icons/elec.png"),
                    // fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "ELECTRICITY",
              style: TextStyle(
                fontSize: ss.height * 0.02,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ],
    );
  }

  yourAccNav() {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => YourAccount()),
    );
  }
}
