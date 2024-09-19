import 'package:flutter/material.dart';

class PlansSelect extends StatefulWidget {
  const PlansSelect({ key}) : super(key: key);

  @override
  _PlansSelectState createState() => _PlansSelectState();
}

class _PlansSelectState extends State<PlansSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
    );
  }
}
