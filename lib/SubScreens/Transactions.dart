import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pluspay/Const/Constants.dart';

class Transactions extends StatefulWidget {
  const Transactions({key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
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
                    FontAwesomeIcons.exchangeAlt,
                    color: Colors.grey[400],
                    size: 15,
                  )),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Transactions",
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
          children: [filter(), txt()],
        ),
      ),
    );
  }

  Widget filter() {
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            height: 50,
            color: Colors.grey[200],
            child: Text(
              " 11/03/2021 TO 11/22/2022",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 50,
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
    );
  }

  txt() {
    return Row(
      children: [
        Text(
          "#",
          style: TextStyle(fontSize: 13),
          maxLines: 2,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            "Date",
            style: TextStyle(fontSize: 13),
            maxLines: 2,
          ),
        ),
        Expanded(
          child: Text(
            "Transaction ID",
            style: TextStyle(fontSize: 13),
            maxLines: 2,
          ),
        ),
        Expanded(
          child: Text(
            "Mobile Number",
            style: TextStyle(fontSize: 13),
            maxLines: 2,
          ),
        ),
        Expanded(
          child: Text(
            "Operator NAME",
            style: TextStyle(fontSize: 13),
          ),
        ),
        Expanded(
          child: Text(
            "Country",
            style: TextStyle(fontSize: 13),
            maxLines: 2,
          ),
        ),
        Expanded(
          child: Text(
            "Amount",
            style: TextStyle(fontSize: 13),
            maxLines: 2,
          ),
        ),
        Expanded(
          child: Text(
            "Status",
            style: TextStyle(fontSize: 13),
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
