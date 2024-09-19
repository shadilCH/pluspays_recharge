import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pluspay/Api/ksebRechargeApi.dart';
import 'package:pluspay/Const/Constants.dart';
import 'package:pluspay/Const/snackbar_toast_helper.dart';
import 'package:pluspay/SubScreens/PaymentSuccess.dart';
import 'package:pluspay/SubScreens/PrintPage.dart';

class PayNow extends StatefulWidget {
  final data;
  final type;
  const PayNow({ key,this.data,this.type}) : super(key: key);

  @override
  _PayNowState createState() => _PayNowState();
}

class _PayNowState extends State<PayNow> {

  var name ;
  var number ;
  var image ;
  var amount ;
  var isLoading = false;
  var isTap = false;
  var lock = true;

  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("xoxoxo");
    //  this.getHome();

    setState(() {
      if(widget.type=="KSEB"){
        lock=false;
        image ="https://www.tesz.in/assets/avatars/kseb.png";
        amountController.text = widget.data['plan_info']['BillAmount'].toString();
        number=widget.data['plan_info']['consumer_number'].toString();
        isLoading = false;
      }



    });


  }


  Future<String> ksebBill(response) async {
    setState(() {
      isTap = true;
    });




    var rsp = await ksebRechargeApi(response['plan_info']['consumer_number'].toString(),response['plan_info']['BillAmount'].toString());
    print("billlllllllllll");
    print(rsp);


    if (rsp != 0 && rsp['status'] == true) {

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Print(id: rsp['transaction_id'].toString())),);

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => PaymentSuccess()),
      // );
      showToast(rsp['message'].toString());

    }else{
      showToast(rsp['message'].toString());

    }






    setState(() {
      isTap = false;
    });

    return " ";

  }
  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Colors.black,
            )),
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Container(
          child: button(),
        ),
      ),
      body:isLoading==true?Container(
          child: Center(child: CircularProgressIndicator())):  Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: ss.height * 0.16,
              width: ss.width * 0.16,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black12),
                  boxShadow: [
                    BoxShadow(
                      color: (Colors.grey.shade400),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(1, 1),
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(
                        image,
                        scale: 1),
                  )),
            ),
            Text(
              "Name",
              style: TextStyle(
                  fontSize: ss.height * 0.025, fontWeight: FontWeight.w600),
            ),
            Text(
              "Number",
              style: TextStyle(
                  fontSize: ss.height * 0.025, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: ss.height * 0.02,
            ),
            txtField(),
          ],
        ),
      ),
    );
  }

  txtField() {
    final ss = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: ss.width * 0.2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          enabled: lock,
          cursorColor: Colors.black,
          keyboardType: TextInputType.number,
          autofocus: false,
          style: TextStyle(
              fontSize: ss.height * 0.04,
              fontWeight: FontWeight.w900,
              color: Colors.grey[700]),
          decoration: new InputDecoration(
            prefixIcon: Icon(
              FontAwesomeIcons.rupeeSign,
              size: ss.height * 0.028,
            ),
            border: InputBorder.none,
            hintStyle: TextStyle(
                fontSize: ss.height * 0.028, fontWeight: FontWeight.w600),
            hintText: "Enter Amount",
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  button() {
    return isTap==true?Container(
      height: 40,
      child: Center(child: CircularProgressIndicator())
      ,
    ):GestureDetector(
      onTap: ()async{
        var rsp = await ksebBill(widget.data);

      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
            color: themeBlue, borderRadius: BorderRadius.circular(10)),
        child: Text(
          "Pay",
          style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.height * 0.03,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
