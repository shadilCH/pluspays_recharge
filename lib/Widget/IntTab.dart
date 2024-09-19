import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pluspay/Api/dashChangeApi.dart';
import 'package:pluspay/Const/Constants.dart';
import 'package:pluspay/Const/sharedPref.dart';
import 'package:pluspay/SubScreens/CountrySelect.dart';
import 'package:pluspay/SubScreens/OperatorSelect.dart';
import 'package:pluspay/Widget/yourAccount.dart';

import '../Api/countryByServiceApi.dart';
import '../main.dart';

class InternationalTab extends StatefulWidget {
  final walletAmnt;
  final dueAmnt;

  // static const routeName = "/property-sell";

  const InternationalTab({key, this.walletAmnt, this.dueAmnt})
      : super(key: key);

  @override
  _InternationalTabState createState() => _InternationalTabState();
}

class _InternationalTabState extends State<InternationalTab> {
  var isLoading = false;
  var arrList = [];
  var Countries = [];
  var selectedCode;
  var dash = "0";

  var wallet_amount;
  var due_amount;
  int _selectedIndex = 0;
  List All = [
    {
      "Size":150.0,
      "text":"International Recharge",
    },
    {
      "Size":100.0,
      "text":"Soudi Prepaid",
    },
    {
      "Size":80.0,
      "text":"Voucher",
    },
    {
      "Size":110.0,
      "text":"Gaming Card",
    },
    {
      "Size":50.0,
      "text":"DTH",
    },
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("xoxoxo");
    getHome();

    setState(() {});
  }
  Future<String> getCountry() async {
    var rsp = await countryByServiceApi("DigitalProduct");
    //
    print("catogerrrrry");
    print(rsp);
    if (rsp != 0) {
      setState(() {
        Countries = rsp['countries'];
      });
    }

    print("catogerrrrry");

    setState(() {
      isLoading = false;
    });

    return " ";
  }
  Future<String> getHome() async {
    setState(() {
      isLoading= true;
    });
    var name = await sharedPrefrence("dash", "1");

    var rsp = await dashFlipApi();
    //
    print("international");
    print(rsp);
    if (rsp != "") {
      setState(() {
        arrList = rsp['mobile_countries'];
        wallet_amount = rsp['wallet_amount'].toString();
        due_amount = rsp['due_amount'].toString();
        // dash = name;
      });
    }

    print("catogerrrrry");
    print(arrList);
    setState(() {
      isLoading = false;
    });

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Container(child: Center(child: CircularProgressIndicator()))
        : SingleChildScrollView(
            child: Container(
                child: Wrap(
              runSpacing: 20,
              children: [
                tab(),
                _selectedIndex==0?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Balance_Due("Balance Amount", wallet_amount),
                    Balance_Due("Due Amount", due_amount)
                  ],
                ):SizedBox(),
                _selectedIndex==0?txtField():SizedBox(),
                _selectedIndex==0?FlagGrid():SizedBox(),

              ],
            )),
          );
  }

  Widget Balance_Due(String txt, String amount) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: themePink,
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
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                amount,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
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
          MaterialPageRoute(builder: (context) => YourAccount()),
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
                    BoxDecoration(shape: BoxShape.circle, color: themePink),
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

  Widget FlagGrid() {
    return Padding(
      padding:  EdgeInsets.only(left: width*0.03,right: width*0.03),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: width*0.08,
            mainAxisSpacing: width*0.01,
            childAspectRatio: 0.8),
        itemCount: arrList != null ? arrList.length : 0,
        itemBuilder: (context, index) {
          final item = arrList != null ? arrList[index] : null;
          return Flags(item, index);
        },
      ),
    );
  }

  Widget tab(){
    return Row(children: [
      Container(
        height: width*0.15,
        width: width*0.9,
        child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      height: width*0.092,
                      width: All[index]["Size"],
                      margin: EdgeInsets.only(left: width*0.035),
                      decoration: BoxDecoration(
                          color:  _selectedIndex==index ? themePink: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(width*0.03)
                      ),
                      child: Center(
                        child: Text(
                          All[index]["text"],
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: TextStyle(color:_selectedIndex==index ? Colors.white: Colors.black, fontSize:width*0.032),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                  width:width*0.01
              );
            },
            itemCount: All.length
        ),
      ),
    ],

    );
  }

  Flags(var item, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => YourAccount(code: item['dial_code'].toString())),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: (Colors.grey.shade400),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(1, 1),
              ),
            ],
            border: Border.all(color: Colors.black12),
            image: DecorationImage(
                image: NetworkImage(
                  item['Cflag'].toString(),
                ),
                fit: BoxFit.contain)),
      ),
    );
  }

  // Widget vouchers(){
  //   return GridView.builder(
  //     itemCount: items.length,
  //     shrinkWrap: true,
  //     physics: NeverScrollableScrollPhysics(),
  //     scrollDirection: Axis.vertical,
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         childAspectRatio: 0.9,
  //         crossAxisSpacing: width*0.01,
  //         mainAxisSpacing: width*0.01,
  //         crossAxisCount: 4),
  //     itemBuilder: (context, index) {
  //       return Column(
  //         children: [
  //           GestureDetector(
  //             onTap: () {
  //
  //               selectItem(index);
  //
  //             },
  //             child: Container(
  //               height: width*0.17,
  //               width: width*0.17,
  //               decoration: BoxDecoration(
  //                 // color: Colors.blue,
  //                   borderRadius: BorderRadius.circular(width * 0.03),
  //                   image: DecorationImage(
  //                       image: NetworkImage(items[index]["sub_cat_logo"]),fit: BoxFit.cover)),
  //               // child: Image.asset(images[index]["image1"],fit: BoxFit.fill,),
  //             ),
  //           ),
  //           SizedBox(
  //             height: width * 0.01,
  //           ),
  //           Text(
  //             items[index]["subcategory"],
  //             overflow: TextOverflow.ellipsis,
  //             style: TextStyle(
  //                 fontWeight: FontWeight.w500, fontSize: width * 0.03),
  //           )
  //         ],
  //       );
  //     },
  //   ),
  // }

  yourAccNav() {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => YourAccount()),
    );
  }

  Voucher() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CountrySelect(service: "DigitalProduct",)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height * 0.08,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: themePink,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white70),
          boxShadow: [
            BoxShadow(
              color: (Colors.grey.shade400),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Wrap(
          spacing: 10,
          children: [
            Image.asset(
              "assets/images/voucher.png",
              height: 20,
              color: Colors.white,
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                "Voucher",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Dth() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CountrySelect(service: "tv",)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height * 0.08,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: themePink,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white70),
          boxShadow: [
            BoxShadow(
              color: (Colors.grey.shade400),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Wrap(
          spacing: 10,
          children: [
            Image.asset(
              "assets/images/voucher.png",
              height: 20,
              color: Colors.white,
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                "DTH",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
