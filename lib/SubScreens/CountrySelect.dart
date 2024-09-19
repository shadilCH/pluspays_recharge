import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pluspay/Api/countryByServiceApi.dart';
import 'package:pluspay/Const/Constants.dart';

import 'OperatorSelect.dart';

class CountrySelect extends StatefulWidget {
  final service;


  CountrySelect({this.service});

  @override
  _CountrySelectState createState() => _CountrySelectState();
}

class _CountrySelectState extends State<CountrySelect> {
  var isLoading = true;
  var arrList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("xoxoxo");
    this.getHome();

    setState(() {});
  }

  Future<String> getHome() async {
    var rsp = await countryByServiceApi(widget.service);
    //
    print("catogerrrrry");
    print(rsp);
    if (rsp != 0) {
      setState(() {
        arrList = rsp['countries'];
      });
    }

    print("catogerrrrry");

    setState(() {
      isLoading = false;
    });

    return " ";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Select a country",
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5),
        ),
        leading: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
          ],
        ),
      ),
      body: isLoading == true
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
              margin: EdgeInsets.all(10),
              child: Scrollbar(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 5,
                  ),
                  shrinkWrap: true,
                  itemCount: arrList != null ? arrList.length : 0,
                  itemBuilder: (context, index) {
                    final item = arrList != null ? arrList[index] : null;
                    return Countries(item, index);
                  },
                ),
              ),
            ),
    );
  }

  Countries(var item, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OperatorSelect(id: item['CountryIso'].toString(),service: widget.service,),),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Container(
          child: Text(
            item['CountryName'].toString(),
            style: TextStyle(
                color: themePink,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
        ),
      ),
    );
  }

  Widget txtField() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: themePink, width: 1)),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 30,
              ),
              child: TextFormField(
                cursorColor: Colors.black,
                autofocus: false,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  prefixIconConstraints:
                      BoxConstraints(minWidth: 0, minHeight: 0),
                  hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: themePink),
                  hintText: "Country Name",
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: themePink),
            margin: EdgeInsets.symmetric(horizontal: 5),
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
    );
  }
}
