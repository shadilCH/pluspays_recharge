import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pluspay/Api/dashChangeApi.dart';
import 'package:pluspay/Api/providersByCountryApi.dart';
import 'package:pluspay/Const/Constants.dart';
import 'package:pluspay/Const/image_const.dart';
import 'package:pluspay/Const/sharedPref.dart';
import 'package:pluspay/SubScreens/CountrySelect.dart';
import 'package:pluspay/SubScreens/OperatorSelect.dart';
import 'package:pluspay/Widget/yourAccount.dart';

import '../Api/countryByServiceApi.dart';
import '../Api/providersByServVoucherNewApi.dart';
import '../SubScreens/OperatorOffers.dart';
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
  var isvoucherLoading = false;
  var arrList = [];
  var Countries = [];
  var selectedCode;
  var dash = "0";
  var wallet_amount;
  var due_amount;
  int _selectedIndex = 0;
  List All = [
    {
      "Size":width*0.3,
      "text":"International\nRecharge",
    },
    {
      "Size":width*0.28,
      "text":"Prepaid",
    },
    {
      "Size":width*0.22,
      "text":"Voucher",
    },
    {
      "Size":width*0.29,
      "text":"Gaming Card",
    },
    {
      "Size":width*0.15,
      "text":"DTH",
    },
  ];
  var prepaidProviders =[
    {
      "image":ImageConst.friendi,
      "name":"Friendi KSA"
    },
    {
      "image":ImageConst.stc,
      "name":"STC KSA"
    },
    {
      "image":ImageConst.mobily,
      "name":"Mobily KSA"
    },
    {
      "image":ImageConst.zain,
      "name":"Zain KSA"
    },
    {
      "image":ImageConst.lebara,
      "name":"Lebara KSA"
    },
    {
      "image":ImageConst.salam,
      "name":"Salam KSA"
    },
    {
      "image":ImageConst.redbull,
      "name":"Red Bull KSA"
    }
  ];
  var provider;
  List<dynamic> allProviders = [];
  List<dynamic> ksaVoucher = [];
  List<dynamic> dthList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("xoxoxo");
    getHome();

    setState(() {
      fetchAllProviders();
      dthproviders();
    });
  }
  Future<List<Map<String, dynamic>>> fetchAllProviders() async {
    setState(() {
      isvoucherLoading= true;
    });
    var countryMap = await countryByServiceApi("DigitalProduct");
    print("dddddddddddddddd");
    print(countryMap);
    var countries=countryMap["countries"];
    for (var countryIso in countries) {
      var country = countryIso["CountryIso"];
      var providers = await providerByCountryApi(country);
      provider = providers["providers"];
      if(country=="SA"){
        ksaVoucher.addAll(providers["providers"]);
      }
      allProviders.addAll(provider);
      setState(() {

      });
    }
    print(allProviders);
    print("nnnnnnnnnnnn");
    setState(() {
      isvoucherLoading= false;
    });
    return [];
  }
  Future<List<Map<String, dynamic>>> dthproviders() async {
    setState(() {
      isvoucherLoading= true;
    });
    var countryMap = await countryByServiceApi("tv");
    print("dddddddddddddddd");
    print(countryMap);
    var countries=countryMap["countries"];
    for (var countryIso in countries) {
      var country = countryIso["CountryIso"];
      var providers = await provSrvVoucherNewApi("tv",country);
      provider = providers["providers"];
      dthList.addAll(provider);
      setState(() {

      });
    }
    print(allProviders);
    print("nnnnnnnnnnnn");
    setState(() {
      isvoucherLoading= false;
    });
    return [];
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Balance_Due("Balance Amount", wallet_amount),
                    SizedBox(
                      width: width*0.04,
                    ),
                    Balance_Due("Due Amount", due_amount)
                  ],
                ):SizedBox(),
                _selectedIndex==0?txtField():SizedBox(),
                _selectedIndex==0?FlagGrid():SizedBox(),
                _selectedIndex==1?prepaid():SizedBox(),
                _selectedIndex == 2?isvoucherLoading==true?Container(child: Center(child: CircularProgressIndicator())):vouchers():SizedBox(),
                _selectedIndex ==4?isvoucherLoading==true?Container(child: Center(child: CircularProgressIndicator())):dth():SizedBox()
              ],
            )),
          );
  }

  Widget Balance_Due(String txt, String amount) {
    return Container(
      height: width*0.22,
      width: width*0.32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: themePink,

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
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: width*0.03,
                    fontWeight: FontWeight.w300),
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                amount,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: width*0.035,
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
          MaterialPageRoute(builder: (context) => YourAccount(code: "",)),
        );
      },
      child: Center(
        child: Container(
          height: width*0.12,
          width: width*0.86,
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
              ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 18,
            ),
            child: Row(
              children: [
                Text(
                  "Mobile Number",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'),
                ),
                Spacer(),
                Padding(
                  padding:  EdgeInsets.only(right: width*0.02),
                  child: CircleAvatar(
                    backgroundColor: themePink,
                    radius: width*0.04,
                    child: Center(
                      child: Icon(
                        Icons.search,
                        size: width*0.05,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
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
            crossAxisSpacing: width*0.05,
            mainAxisSpacing: width*0.01,
            childAspectRatio: 0.85),
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
        height: width*0.11,
        width: width*0.93,
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
                      height: width*0.11,
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
                          style: TextStyle(color:_selectedIndex==index ? Colors.white: Colors.black, fontSize:width*0.027),
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
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => YourAccount(code: item['dial_code'].toString())),
            );
          },
          child: Container(
            height: width*0.14,
            width: width*0.16,
            decoration: BoxDecoration(
                shape: BoxShape.circle,

                border: Border.all(color: Colors.black12),
                image: DecorationImage(
                    image: NetworkImage(
                      item['Cflag'].toString(),
                    ),
                    fit: BoxFit.contain)),
          ),
        ),
        Text(
          item["CountryName"],
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: width * 0.025),
        )
      ],
    );
  }

  prepaid(){
    return Padding(
      padding:  EdgeInsets.only(left: width*0.04,right: width*0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("   Prepaid KSA",style: TextStyle(
            fontSize: width*0.045,
            fontWeight: FontWeight.bold
          ),),
          SizedBox(
            height: width*0.04,
          ),
          GridView.builder(
            itemCount: prepaidProviders.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                crossAxisSpacing: width*0.01,
                mainAxisSpacing: width*0.01,
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => YourAccount(
                                code: "966",
                              ksa:"ksa"
                            )),
                          );
                        },
                        child: Container(
                          height: width*0.35,
                          width: width*0.37,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              image: DecorationImage(image:AssetImage(prepaidProviders[index]["image"]!),fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(width*0.03)
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: width*0.01,),
                  Text(prepaidProviders[index]["name"]!,style: TextStyle(fontSize: width*0.03),)
                ],
              );
            },
          ),
          Divider(
            indent: width*0.03,
            endIndent: width*0.03,
          ),
          SizedBox(
            height: width*0.02,
          ),
          Text("   Vouchers KSA",style: TextStyle(
              fontSize: width*0.045,
              fontWeight: FontWeight.bold
          ),),
          SizedBox(
            height: width*0.04,
          ),
          GridView.builder(
            itemCount: ksaVoucher.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.9,
                crossAxisSpacing: width*0.01,
                mainAxisSpacing: width*0.01,
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OperatorOffers(
                                  id: ksaVoucher[index]['ProviderCode'].toString(),
                                  service: "DigitalProduct",
                                )),
                          );
                        },
                        child: Container(
                          height: width*0.35,
                          width: width*0.37,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              image: DecorationImage(image: NetworkImage(ksaVoucher[index]["logo"]),fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(width*0.03)
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: width*0.01,),
                  Text(ksaVoucher[index]["provider_name"],textAlign: TextAlign.center,style: TextStyle(fontSize: width*0.03),)
                ],
              );
            },
          )

        ],
      ),
    );
  }

  Widget vouchers(){
    return GridView.builder(
      itemCount: allProviders.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.9,
          crossAxisSpacing: width*0.01,
          mainAxisSpacing: width*0.04,
          crossAxisCount: 4),
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OperatorOffers(
                        id: allProviders[index]['ProviderCode'].toString(),
                        service: "DigitalProduct",
                      )),
                );

              },
              child: Container(
                height: width*0.17,
                width: width*0.17,
                decoration: BoxDecoration(
                  // color: Colors.blue,
                    borderRadius: BorderRadius.circular(width * 0.03),
                    image: DecorationImage(
                        image: NetworkImage(allProviders[index]["logo"]),fit: BoxFit.fitHeight)),
                // child: Image.asset(images[index]["image1"],fit: BoxFit.fill,),
              ),
            ),
            SizedBox(
              height: width * 0.01,
            ),
            Expanded(
              child: Text(
                allProviders[index]["provider_name"],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: width * 0.025),
              ),
            )

          ],
        );
      },
    );
  }

  dth(){
    return Padding(
      padding:  EdgeInsets.only(left: width*0.04,right: width*0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            itemCount: dthList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                crossAxisSpacing: width*0.01,
                mainAxisSpacing: width*0.01,
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OperatorOffers(
                                  id: dthList[index]['ProviderCode'].toString(),
                                  service: "DigitalProduct",
                                )),
                          );
                        },
                        child: Container(
                          height: width*0.35,
                          width: width*0.37,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              image: DecorationImage(image: NetworkImage(dthList[index]["logo"]),fit: BoxFit.contain),
                              borderRadius: BorderRadius.circular(width*0.03)
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: width*0.01,),
                  Text(dthList[index]["provider_name"],style: TextStyle(fontSize: width*0.03),)
                ],
              );
            },
          ),
        ],
      ),
    );
  }

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
