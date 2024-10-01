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
          preferredSize: Size.fromHeight(height*0.1),
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
                height: height*0.065,),
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
                    padding:  EdgeInsets.all(width*0.03),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: width*1,
                          height: height*0.065,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width*0.06),
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
                                  Border.all(color: Colors.black12, width: width*0.002)),
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
                                    width*0.035,
                                fontWeight: FontWeight.bold,
                                letterSpacing: width*0.003),
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
                                        topLeft: Radius.circular(width*0.06),
                                        bottomLeft: Radius.circular(width*0.06))
                                    : BorderRadius.only(
                                        topRight: Radius.circular(width*0.06),
                                        bottomRight: Radius.circular(width*0.06)),
                            ),
                            unselectedLabelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.bold),
                            unselectedLabelColor:Colors.black,
                            automaticIndicatorColorAdjustment: true,
                            // labelStyle: bold14,
                          ),
                        ),
                        SizedBox(
                          height: height*0.03,
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
