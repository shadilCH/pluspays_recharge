import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pluspay/Api/providersByCountryApi.dart';
import 'package:pluspay/SubScreens/OperatorOffers.dart';

import '../Widget/yourAccount.dart';
import '../main.dart';

class ProviderSelect extends StatefulWidget {
  final countryIso;
  const ProviderSelect({super.key, this.countryIso});

  @override
  State<ProviderSelect> createState() => _ProviderSelectState();
}

class _ProviderSelectState extends State<ProviderSelect> {
  var isLoading = false;
  var provList = [];

  fetchProvider() async {
    setState(() {
      isLoading= true;
    });
    var rsp =await providerByCountryApi(widget.countryIso,"Mobile");
    print(rsp);
    print("rsp");
    if (rsp != null) {

        provList = rsp['providers'];
        print(provList);
        print("mkmkmkm");

    }
    setState(() {
      isLoading=false;
    });
  }
  @override
  void initState() {
    fetchProvider();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Select provider",
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5),
        ),
      ),
      body: isLoading!=true?SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              itemCount: provList != null ? provList.length : 0,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisSpacing: width*0.01,
                  mainAxisSpacing: height*0.008,
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final item = provList != null ? provList[index] : null;
                return Column(
                  children: [
                    SizedBox(
                      height: height*0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OperatorOffers(
                                id: item['ProviderCode'].toString(),
                                service: "Mobile",
                              )),
                            );
                          },
                          child: Container(
                            height: height*0.17,
                            width: width*0.37,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(width*0.03)
                            ),
                            child: Center(
                              child: Container(
                                height: height*0.13,
                                width: width*0.3,
                                child: Image(image:NetworkImage(item["logo"]!),fit: BoxFit.contain),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height*0.008,),
                    Text(item["provider_name"]!,style: TextStyle(fontSize: width*0.03),)
                  ],
                );
              },
            ),
        
          ],
        ),
      ):Container(
        child: Center(child: CircularProgressIndicator()),
      )
    );
  }
}
