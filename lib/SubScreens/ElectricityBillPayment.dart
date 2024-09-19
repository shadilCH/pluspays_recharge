import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pluspay/Api/ksebBillApi.dart';
import 'package:pluspay/Api/ksebRechargeApi.dart';
import 'package:pluspay/Const/Constants.dart';
import 'package:pluspay/Const/snackbar_toast_helper.dart';
import 'package:pluspay/Screens/PayNow.dart';

class Newpayment extends StatefulWidget {
  const Newpayment({ key}) : super(key: key);

  @override
  _NewpaymentState createState() => _NewpaymentState();
}

class _NewpaymentState extends State<Newpayment> {



  var isLoading = false;
  var _validate = false;
  TextEditingController consumerController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("xoxoxo");
  //  this.getHome();

    setState(() {});
  }

  Future<String> getBill(id) async {
    setState(() {
      isLoading = true;
    });

    var rsp = await ksebBillApi(id);
    //
    print("catogerrrrry");
    print(rsp);


    if (rsp != 0 && rsp['status'] == true) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PayNow(data: rsp,type: "KSEB",)),
      );


    }else{

      showToast(rsp['message'].toString());
    }


    setState(() {
      isLoading = false;
    });

    return " ";
  }


  Future<String> payBill(response) async {
    setState(() {
      isLoading = true;
    });




   var rsp = await ksebRechargeApi(response['plan_info']['consumer_number'].toString(),response['plan_info']['BillAmount'].toString());
    print("billlllllllllll");
    print(rsp);


    if (rsp != 0 && rsp['status'] == true) {
      showToast(rsp['message'].toString());

    }else{
      showToast(rsp['message'].toString());

    }






    setState(() {
      isLoading = false;
    });

    return " ";

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: button(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Electricity Bill payment",
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              txtField(),
              SizedBox(
                height: 10,
              ),
              Text(
                "Please enter a valid consumer number.",
                style: TextStyle(color: Colors.black54, fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }

  txtField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: consumerController,

      style: TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
          fontSize: MediaQuery.of(context).size.height * 0.025,
          color: Colors.black),
      decoration: new InputDecoration(
        errorText: _validate ? 'Consumer Number Can\'t Be Empty' : null,
        labelText: "Consumer Number",
        labelStyle: TextStyle(
            color: Colors.black26,
            fontSize: MediaQuery.of(context).size.height * 0.025),
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(10),
          borderSide: new BorderSide(
            width: 1,
          ),
        ),
        //fillColor: Colors.green
      ),
    );
  }

  button() {
    return isLoading==true?Container(
      height: 40,
      child: Center(child: CircularProgressIndicator())
      ,
    ):GestureDetector(
      onTap: (){
        if(consumerController.text.isNotEmpty){
          setState(() {
            _validate = false;

          });
          getBill(consumerController.text.toString());

        }else{
         setState(() {
           _validate = true;

         });
        }

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
