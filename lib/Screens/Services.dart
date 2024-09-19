import 'package:flutter/material.dart';
import 'package:pluspay/Api/servicesApi.dart';
import 'package:pluspay/Const/network.dart';
import 'package:pluspay/SubScreens/PaymentSuccess.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({ key}) : super(key: key);

  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {


  var arrProdList = [];

  var  isLoading = true;
  var  totalSale = "";
  var  totalProfit = "";


  //List<dynamic> data = [];
  @override
  void initState() {

    super.initState();

    print("xoxoxo");
    this.getHome();


    setState(() {});


  }

  Future<String> getHome() async {
    print("xoxoxo");

    var rsp = await servicesApi();
    print("arrProdList");
    print(rsp);


    // arrProdList = data;
    //
    if(rsp['status']==true){



      setState(() {

        arrProdList = rsp['other_services'];

        // totalSale = rsp['total_card_sale'].toString();
        // totalProfit = "₹"+rsp['total_profit'].toString();

      });

    }


    setState(() {
      isLoading = false;
    });

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: false,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          title: Image(
              image: AssetImage(
                "assets/images/logo.png",
              ),
              height: 60),
        ),
      ),
      body: isLoading==true?Container(
          child: Center(child: CircularProgressIndicator())):Container(
        margin: EdgeInsets.all(10),
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.9),
          itemCount: arrProdList != null ? arrProdList.length: 0,
          itemBuilder: (context, index) {
            final item = arrProdList != null ? arrProdList[index] : null;
            return ServiceList(item,index);
          },
        ),
      ),
    );
  }

  ServiceList(var item,int index) {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black45)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
            image: NetworkImage(
                servImgUrl+item['logo'].toString()),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
