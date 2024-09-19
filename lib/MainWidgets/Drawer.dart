import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pluspay/Api/walletAmnt.dart';
import 'package:pluspay/Const/Constants.dart';
import 'package:pluspay/Const/sharedPref.dart';
import 'package:pluspay/Screens/ChangePIN.dart';
import 'package:pluspay/Screens/FundsPage.dart';
import 'package:pluspay/Screens/Transactions.dart';
import 'package:pluspay/Screens/login.dart';
import 'package:pluspay/SubScreens/DueSummary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  var arrProdList = [];
  var arrBannerList = [];
  var isLoading = true;
  var wallet_amount;
  var due_amount;
  var name;

  var dash = "0";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("xoxoxo");
    this.getHome();

    setState(() {});
  }

  Future<String> getHome() async {
    var ds = await getSharedPrefrence("dash");
   // name = await getSharedPrefrence('name');
    setState(() {
      dash = ds;
    });
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
    final ss = MediaQuery.of(context).size;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: SafeArea(
        child: ClipRRect(
          child: SizedBox(
            child: Drawer(
              backgroundColor: Colors.white,
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Stack(children: [
                    Wrap(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      runSpacing: ss.height * 0.025,
                      children: [
                        // FittedBox(
                        //   fit: BoxFit.fitWidth,
                        //   child: Text(
                        //     name!=null?name:"",
                        //     maxLines: 1,
                        //     style: TextStyle(
                        //         color: dash == "1" ? themePink : themeBlue,
                        //         fontSize: ss.height * 0.035,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        Text(
                          wallet_amount != null
                              ? "Wallet Amount : " + wallet_amount
                              : "",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: ss.height * 0.022,
                          ),
                        ),
                        Text(
                          due_amount != null
                              ? "Due Amount : " + due_amount
                              : "",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: ss.height * 0.022,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                        ),
                        _createDrawerItem(
                            iccon: FontAwesomeIcons.exchangeAlt,
                            text: "Transaction",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Trans()),
                              );
                            }),
                        _createDrawerItem(
                            iccon: FontAwesomeIcons.coins,
                            text: "Due Summary",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DuePage()),
                              );
                            }),
                        _createDrawerItem(
                            iccon: FontAwesomeIcons.handHoldingUsd,
                            text: "Fund",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FundsPage()),
                              );
                            }),
                        _createDrawerItem(
                            iccon: FontAwesomeIcons.pen,
                            text: "Change Password",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChangePIN()),
                              );
                            }),
                      ],
                    ),
                    Align(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Divider(
                              color: Colors.black38,
                            ),
                            _createDrawerItem(
                                iccon: FontAwesomeIcons.powerOff,
                                text: "Log Out",
                                onTap: () {
                                  showAlertDialog(context);
                                }),
                          ],
                        ),
                        alignment: Alignment.bottomLeft)
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createDrawerItem(
      {String? text, IconData? iccon, GestureTapCallback? onTap}) {
    final ss = MediaQuery.of(context).size;

    return InkWell(
      splashColor: themeBlue,
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                    color: (Colors.grey.shade400),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  iccon,
                  color: Colors.grey[400],
                  size: ss.height * 0.026,
                ),
              ),
            ),
            SizedBox(
              width: ss.width * 0.04,
            ),
            Expanded(
              child: Text(
                text!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: ss.height * 0.02),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    final ss = MediaQuery.of(context).size;

    Widget cancelButton = TextButton(
      child: Text(
        "No",
        style:
            TextStyle(fontSize: ss.height * 0.023, fontWeight: FontWeight.w600),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Yes",
        style:
            TextStyle(fontSize: ss.height * 0.023, fontWeight: FontWeight.w600),
      ),
      onPressed: () async {
        var id = await sharedPrefrence("userId",null);
        var token = await sharedPrefrence("token",null);
        
        var name = await sharedPrefrence("name",null);
        print("logout");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Confirm Logout?",
        style:
            TextStyle(fontSize: ss.height * 0.025, fontWeight: FontWeight.w600),
      ),
      content: Text(
        "Are you sure you want to logout?",
        style:
            TextStyle(fontSize: ss.height * 0.023, fontWeight: FontWeight.w500),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
