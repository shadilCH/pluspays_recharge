import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pluspay/Const/Constants.dart';

class PayNow extends StatefulWidget {
  @override
  _PayNowState createState() => _PayNowState();
}

class _PayNowState extends State<PayNow> {
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
              Icons.close,
              color: Colors.black,
            )),
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Container(
          child: button(),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: ss.height * 0.16,
              width: ss.width * 0.16,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black12),
                  boxShadow: [
                    BoxShadow(
                      color: (Colors.grey.shade400),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(1, 1),
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
                        scale: 1),
                  )),
            ),
            Text(
              "Name",
              style: TextStyle(
                  fontSize: ss.height * 0.025, fontWeight: FontWeight.w600),
            ),
            Text(
              "Number",
              style: TextStyle(
                  fontSize: ss.height * 0.025, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: ss.height * 0.02,
            ),
            txtField(),
          ],
        ),
      ),
    );
  }

  txtField() {
    final ss = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: ss.width * 0.2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          cursorColor: Colors.black,
          keyboardType: TextInputType.number,
          autofocus: false,
          style: TextStyle(
              fontSize: ss.height * 0.04,
              fontWeight: FontWeight.w900,
              color: Colors.grey[700]),
          decoration: new InputDecoration(
            prefixIcon: Icon(
              FontAwesomeIcons.rupeeSign,
              size: ss.height * 0.028,
            ),
            border: InputBorder.none,
            hintStyle: TextStyle(
                fontSize: ss.height * 0.028, fontWeight: FontWeight.w600),
            hintText: "Enter Amount",
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  button() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
            color: themeBlue, borderRadius: BorderRadius.circular(10)),
        child: Text(
          "Pay Now",
          style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.height * 0.025,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
