import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pluspay/Api/walletAmnt.dart';
import 'package:pluspay/Const/Constants.dart';
import 'package:pluspay/Const/sharedPref.dart';
import 'package:pluspay/Const/snackbar_toast_helper.dart';
import 'package:pluspay/Screens/login.dart';
import 'package:pluspay/Widget/IndianTab.dart';
import 'package:pluspay/Widget/IntTab.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({ key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLoading = true;
  var wallet_amount;
  var due_amount;
  var selct = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("xoxoxo");
    this.getHome();

    setState(() {});
  }

  Future<String> getHome() async {
    var rsp = await walletAmnt();
    //
    print("catogerrrrry");
    print(rsp);
    if(rsp['status']==true){
      setState(() {
        wallet_amount = rsp['wallet_amount'].toString();
        due_amount = rsp['due_amount'].toString();
      });
    }else{
      var token = await sharedPrefrence("token",null);

      var name = await sharedPrefrence("name",null);
      print("logout");
      showToast("Session timeout !");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            title: Image(
                image: AssetImage(
                  "assets/images/logo.png",
                ),
                height: 55),
          ),
        ),
        body: isLoading == true
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : DefaultTabController(
                length: 2,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: width*1,
                          height: width*0.13,
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
                              border:
                                  Border.all(color: Colors.black12, width: 1)),
                          child: TabBar(
                            isScrollable: false,
                            onTap: (index) {
                              setState(() {
                                selct = index;
                              });
                              print(index);
                            },
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize:
                                    MediaQuery.of(context)
                                        .size.width * 0.035,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                            tabs: [
                              Tab(
                                text: "INTERNATIONAL",
                              ),
                              Tab(
                                text: "INDIAN",
                              ),

                            ],
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                                gradient: selct == 0
                                    ? LinearGradient(
                                    stops: [0.7, 1],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [themePink, Colors.white]):
                                LinearGradient(
                                        stops: [0.7, 2],
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                        colors: [themeBlue, Colors.white]),
                                // color: selct == 0 ? themeBlue : themePink,
                                borderRadius: selct == 0
                                    ? BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25))
                                    : BorderRadius.only(
                                        topRight: Radius.circular(25),
                                        bottomRight: Radius.circular(25)),
                            ),
                            unselectedLabelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.bold),
                            unselectedLabelColor:Colors.black,
                            automaticIndicatorColorAdjustment: true,
                            // labelStyle: bold14,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Flexible(
                          child: Container(
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                Container(
                                  child: InternationalTab(
                                    walletAmnt: wallet_amount,
                                    dueAmnt: due_amount,
                                  ),
                                ),
                                Container(
                                  child: IndianTab(
                                    walletAmnt: wallet_amount,
                                    dueAmnt: due_amount,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
