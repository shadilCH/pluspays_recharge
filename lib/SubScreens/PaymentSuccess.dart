import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pluspay/Const/Constants.dart';
import 'package:pluspay/MainWidgets/BottomNav.dart';
import 'package:pluspay/Screens/Transactions.dart';

class PaymentSuccess extends StatefulWidget {
  @override
  _PaymentSuccessState createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Container(
            child: button(),
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.1),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
          ),
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/images/success.json',
                  width: MediaQuery.of(context).size.width * 0.4,
                  repeat: false,
                ),
                Text(
                  "Transaction Completed",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.025,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  button() {
    return GestureDetector(
      onTap: () {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Trans(

              )),
        );
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
            color: themeBlue, borderRadius: BorderRadius.circular(10)),
        child: Text(
          "View Transaction",
          style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.height * 0.025,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNav()),
    );
    // Return a value wrapped in a Future
    return Future.value(true);
  }

}
