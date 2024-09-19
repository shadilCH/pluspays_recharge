import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pluspay/Const/Constants.dart';

class Funds extends StatefulWidget {
  const Funds({ key}) : super(key: key);

  @override
  _FundsState createState() => _FundsState();
}

class _FundsState extends State<Funds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            )),
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black45)),
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    FontAwesomeIcons.handHoldingUsd,
                    color: Colors.grey[400],
                    size: 15,
                  )),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Fund",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            filter(),
            SizedBox(
              height: 10,
            ),
            txt()
          ],
        ),
      ),
    );
  }

  Widget filter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: 40,
              color: Colors.grey[200],
              child: Text(
                " 11/03/2021 TO 11/22/2022",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            color: themePink,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "FILTER",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  txt() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "#",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 13),
          maxLines: 2,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "Date",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 13),
          maxLines: 2,
        ),
        SizedBox(
          width: 5,
        ),
        _item("Previous Balance"),
        _item("Amount Deposited"),
        FittedBox(
          child: _item("Commission"),
        ),
        SizedBox(
          width: 3,
        ),
        _item("Total Wallet"),
        _item("Previous Due"),
        _item("Total Due"),
      ],
    );
  }

  _item(String txt) {
    return Expanded(
      child: Text(
        txt,
        style: TextStyle(fontSize: 13),
        maxLines: 3,
      ),
    );
  }
}
