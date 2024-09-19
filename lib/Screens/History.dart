import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pluspay/Api/transactionSaleApi.dart';
import 'package:pluspay/Const/Constants.dart';
import 'package:pluspay/SubScreens/PrintPage.dart';



class HistoryPage extends StatefulWidget {
  @override
  _TransState createState() => _TransState();
}

class _TransState extends State<HistoryPage> {


  var purchaseDate ="0";



  var start =DateTime.now().year.toString()+"-"+DateTime.now().month.toString()+"-"+DateTime.now().day.toString();
  var end =DateTime.now().year.toString()+"-"+DateTime.now().month.toString()+"-"+DateTime.now().day.toString();


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
    arrProdList.clear();
    var rsp = await transactionSaleApi(start,end);



    // arrProdList = data;
    //
    if(rsp['status']==true){



      setState(() {

        arrProdList = rsp['transactions'];

        // totalSale = rsp['total_card_sale'].toString();
        // totalProfit = "₹"+rsp['total_profit'].toString();

      });
      print("arrProdList");
      print(arrProdList);
    }


    setState(() {
      isLoading = false;
    });

    return "";
  }









  Future selectDateRange(BuildContext context) async {
    DateTimeRange? pickedRange = (await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now(),
      ),
      firstDate: DateTime(DateTime.now().year + -5),
      lastDate: DateTime(DateTime.now().year + 2),
      helpText: 'Select Date Range',
      cancelText: 'CANCEL',
      confirmText: 'OK',
      saveText: 'SAVE',
      errorFormatText: 'Invalid format.',
      errorInvalidText: 'Out of range.',
      errorInvalidRangeText: 'Invalid range.',
      fieldStartHintText: 'Start Date',
      fieldEndLabelText: 'End Date',
    ));

    if (pickedRange != null) {
      setState(() {
        start = pickedRange.start.year.toString() +
            "-" +
            pickedRange.start.month.toString() +
            "-" +
            pickedRange.start.day.toString();
        end = pickedRange.end.year.toString() +
            "-" +
            pickedRange.end.month.toString() +
            "-" +
            pickedRange.end.day.toString();
      });

      getHome();
      print(pickedRange.start.day);
      print(pickedRange.start.month);
      print(pickedRange.start.year);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50]?.withOpacity(0.99),
      // floatingActionButton: FloatingActionButton(
      //   onPressed:arrProdList.length==0?null: () {
      //     _showDialog(context);
      //     // Navigator.push(
      //     //   context,
      //     //   MaterialPageRoute(builder: (context) => TransactionPrint()),
      //     // );
      //   },
      //   child: const Icon(Icons.print),
      //   backgroundColor: arrProdList.length==0?Colors.grey:themeColor,
      // ),

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
      body:isLoading==true?Container(
          child: Center(child: CircularProgressIndicator())): SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Wrap(
            runSpacing: 15,
            alignment: WrapAlignment.center,
            children: [

              FilterSection(),
              //  totalSales(),
              ListView.separated(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
                shrinkWrap: true,
                itemCount: arrProdList != null ? arrProdList.length: 0,
                itemBuilder: (context, index) {
                  final item = arrProdList != null ? arrProdList[index] : null;

                  return Details(index,item);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget FilterSection() {
    return   Padding(
      padding: const EdgeInsets.only(top:5.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.date_range,
                size: 15,
                color: Colors.green,
              ),
              SizedBox(width: 10,),
              Expanded(
                flex: 1,
                child: Text(
                  start +" to "+end,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              returnRangePicker(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget returnRangePicker(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          hintColor: Colors.green,
          primaryColor: Colors.blue,
          buttonTheme: ButtonThemeData(
              highlightColor: Colors.green,
              buttonColor: Colors.green,
              colorScheme: Theme.of(context).colorScheme.copyWith(
                  secondary: Colors.redAccent,
                  background: Colors.white,
                  primary: Colors.green,
                  brightness: Brightness.dark,
                  onBackground: Colors.green),
              textTheme: ButtonTextTheme.accent)),
      child: Builder(
        builder: (context) => SizedBox(
          height: 30,
          child: GestureDetector(
            onTap: ()async {

              selectDateRange(context);
            },
            child: Text(
              "FILTER",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }

  Widget totalSales(){
    return    Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.sync_alt_sharp,
                size: 15,
                color: Colors.green,
              ),
              SizedBox(width: 16,),
              Expanded(
                flex: 1,
                child: Text(
                  "Total Card Sales : "+ purchaseDate,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget Button() {
    return SizedBox(
      height: 20,
      child: GestureDetector(
        onTap: () {},
        child: Text(
          "FILTER",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
    );
  }

  Details(int index,var item) {
    final ss = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => Print(id: item['TransactionID'].toString(),),));
      },
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                height: ss.height * 0.1,
                width: ss.width * 0.15,
                color: Colors.blue[400],
                child: Text(
                  item['provider_name'].toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ss.height * 0.02,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['TransactionID'].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: ss.height * 0.025),
                  ),
                  Text(
                    item['RechargedTime'].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[500],
                        fontSize: ss.height * 0.02),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    item['recharge_amount'].toString().split(" ").first.toString(),
                    style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: ss.height * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    item['recharge_amount'].toString().split(" ").last.toString(),
                    style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: ss.height * 0.018,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: Colors.green),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "SUCCESS",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ss.height * 0.018,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
      ),




    );
  }


  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        // Text(
                        //   'Confirm Purchase?',
                        //   style: TextStyle(fontSize: 20),
                        // ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: ()async {





                                },
                                child: Text(
                                  'SUNMI V2',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              // Spacer(
                              //   flex: 1,
                              // ),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => BtTestListPrint(data:arrProdList,nwdate: start +" to "+end,title: "Transactions",)),
                                  // );
                                },
                                child: Text(
                                  'BT PRINT',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ]),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  child: Text(
                    'Choose Printer',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ));
      },
    );
  }

}
