import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pluspay/Api/providersByCountryApi.dart';
import 'package:pluspay/Api/providersByServApi.dart';
import 'package:pluspay/Api/providersByServVoucherNewApi.dart';
import 'package:pluspay/Const/Constants.dart';
import 'package:pluspay/Const/sharedPref.dart';
import 'package:pluspay/SubScreens/PostPaidBillPayment.dart';

import 'OperatorOffers.dart';

class OperatorSelect extends StatefulWidget {
  final id;
  final service;
  final plan;
  const OperatorSelect({ key, this.id, this.service, this.plan})
      : super(key: key);

  @override
  _OperatorSelectState createState() => _OperatorSelectState();
}

class _OperatorSelectState extends State<OperatorSelect> {
  var isLoading = true;
  var arrList = [];
  var dash = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("xoxoxo");
    print(widget.id);
    this.getHome();
    print("serviceeee");
    print(widget.service);
    print(widget.id);
    setState(() {});
  }

  Future<String> getHome() async {
    var ds = await getSharedPrefrence("dash");
    setState(() {
      dash = ds;
    });
    var rsp;
    if (widget.service == null || widget.service=="DigitalProduct") {
      print("noww recharge");

      rsp = await providerByCountryApi(widget.id.toString());
    } else if (widget.service == "tv"){
      print("noww tvvv");
      rsp = await provSrvVoucherNewApi(widget.service.toString(), widget.id.toString());
    }
    else{
      print("noww 22");

      rsp = await provSrvApi(widget.service.toString(), widget.plan.toString());
    }

    //
    print("providersssss");
    print(rsp);
    if (rsp != 0) {
      setState(() {
        dash = ds;
        arrList = rsp['providers'];


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
          "Select provider",
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: isLoading == true
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : arrList == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/no.png",
                        width: MediaQuery.of(context).size.width * 0.6,
                      ),
                      Text(
                        "No Data",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Scrollbar(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
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
    final ss = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        if (widget.plan == "2") {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostPaid(
                      prvdCode: item['ProviderCode'].toString(),
                    )),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OperatorOffers(
                      id: item['ProviderCode'].toString(),
                      type: widget.plan,
                        service: widget.service,
                    )),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: ss.width * 0.03,
            ),
            Container(
              height: ss.height * 0.08,
              width: ss.width * 0.12,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 1),
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                      item['logo'].toString(),
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              width: ss.width * 0.03,
            ),
            Expanded(
              child: Text(
                item['provider_name'].toString(),
                style: TextStyle(
                    color: dash == "1" ? themePink : themeBlue,
                    fontSize: ss.height * 0.025,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
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
                  hintText: "Provider Name",
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
