import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pluspay/Api/RechargeApi.dart';
import 'package:pluspay/Api/ksebBillApi.dart';
import 'package:pluspay/Api/ksebRechargeApi.dart';
import 'package:pluspay/Const/Constants.dart';
import 'package:pluspay/Const/snackbar_toast_helper.dart';

class PostPaid extends StatefulWidget {
  final prvdCode;
  const PostPaid({key,this.prvdCode}) : super(key: key);

  @override
  _NewpaymentState createState() => _NewpaymentState();
}

class _NewpaymentState extends State<PostPaid> {



  var isLoading = false;
  var _validate = false;
  var _amount = false;
  TextEditingController consumerController = TextEditingController();
  TextEditingController amntController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("xoxoxo");
  //  this.getHome();

    setState(() {});
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: button(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Prepaid Bill payment",
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
              txtFieldAmnt(),
              SizedBox(
                height: 10,
              ),
              Text(
                "Please enter valid mobile number & amount.",
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
        errorText: _validate ? 'Mobile Number Can\'t Be Empty' : null,
        labelText: "Mobile Number",
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

  txtFieldAmnt() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: amntController,

      style: TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
          fontSize: MediaQuery.of(context).size.height * 0.025,
          color: Colors.black),
      decoration: new InputDecoration(
        errorText: _amount ? 'Payable amount Can\'t Be Empty' : null,
        labelText: "Payable amount",
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
      onTap: ()async{
        if(consumerController.text.isEmpty){
          setState(() {
            _validate = true;

          });
          // getBill(consumerController.text.toString());
             return;
        }

        setState(() {

          _validate = false;

        });
        if(amntController.text.isEmpty){
          setState(() {
            _amount = true;

          });
          // getBill(consumerController.text.toString());
          return;
        }


        setState(() {
          _amount = false;


        });
        var rsp = await RechargeApi(
            widget.prvdCode.toString(),
            consumerController.text.toString(),
            "NA",
            "NA",
            amntController.text.toString(),
            "NA",
            "2","NA",true,amntController.text);
        if (rsp != 0 && rsp['status'] == true) {
          showToast(rsp['message'].toString());

        } else {
          showToast(rsp['message'].toString());
        }

        setState(() {
          _amount = false;
          _validate = false;

        });


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
