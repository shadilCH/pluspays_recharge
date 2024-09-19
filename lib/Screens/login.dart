import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pluspay/Api/logIn.dart';
import 'package:pluspay/Const/Constants.dart';
import 'package:pluspay/Const/sharedPref.dart';
import 'package:pluspay/Const/snackbar_toast_helper.dart';
import 'package:pluspay/MainWidgets/BottomNav.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var onClick = false;
  var isCheck = false;

  @override
  void initState() {

    super.initState();

    print("xoxoxo");
    this.getHome();


    setState(() {
      _passwordVisible = false;
    });


  }

  Future<String> getHome() async {

    var ck = await getSharedPrefrence(chek);
    print("checkkkkkk");
    print(ck);
    if(ck=="true"){
      var us = await getSharedPrefrence(unm);
      var pws =await getSharedPrefrence(ps);

      setState(() {
        usernameController.text=us;
        passController.text=pws;
        isCheck=true;
      });
    }
    return "";
  }




  Future<bool> _onBackPressed() {
    SystemNavigator.pop();
    return Future<bool>.value(true);
  }

  bool _passwordVisible = false;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: AppBar(
            backgroundColor: Colors.white,
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          // color: Colors.red,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: height * 0.2,
                    child: Image.asset('assets/images/logo.png',
                        fit: BoxFit.cover)),
                SizedBox(
                  height: height * 0.1,
                ),
                textfield1("Username"),
                SizedBox(
                  height: height * 0.02,
                ),
                textfield2("Password"),
                SizedBox(height: 5,),
                checkBox(),
                SizedBox(
                  height: height * 0.03,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNav()),
                      );
                    },
                    child: button("LOGIN"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textfield1(String label) {
    return TextFormField(
      controller: usernameController,
      decoration: new InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black26, fontSize: 15),
        fillColor: themeBlue,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(5),
          borderSide: new BorderSide(),
        ),
      ),
    );
  }

  Widget textfield2(String label) {
    return TextFormField(
      controller: passController,
      obscureText: !_passwordVisible,
      decoration: new InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        labelStyle: TextStyle(color: Colors.black26, fontSize: 15),
        fillColor: themeBlue,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(5),
          borderSide: new BorderSide(),
        ),
      ),
    );
  }

  Widget checkBox() {
    return Container(
     // padding: const EdgeInsets.symmetric(horizontal: 30),
      child:   Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
            height: 24.0,
            width: 24.0,
            child: Theme(
              data: ThemeData(
                  unselectedWidgetColor: Color(0xff00C8E8) // Your color
              ),
              child: Checkbox(
                  activeColor: Color(0xff00C8E8),
                  value: isCheck,
                  onChanged: (v)async{
                    setState(() {
                      isCheck=v!;


                    });

                    if(isCheck==true&&usernameController.text.isNotEmpty&&passController.text.isNotEmpty){
                      var un = await sharedPrefrence(unm, usernameController.text.toString() );
                      var pass = await sharedPrefrence(ps, passController.text.toString());
                      var ck = await sharedPrefrence(chek, "true");
                    }else{
                      var un = await sharedPrefrence(unm, null );
                      var pass = await sharedPrefrence(ps, null);
                      var ck = await sharedPrefrence(chek, null);

                    }
                  }),
            )),
        SizedBox(width: 10.0),
        Text("Remember Me",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold,))
      ]),
    );}

  Widget button(String label) {
    return onClick == true
        ? Container(
            height: 50,
            child: Center(child: CircularProgressIndicator()),
          )
        : GestureDetector(
            onTap: onClick == true
                ? null
                : () async {
                    setState(() {
                      onClick = true;
                    });
                    var rsp = await loginApi(usernameController.text.toString(),
                        passController.text.toString());
                    print("rspppp");
                    print(rsp);
                    if (rsp['success'] == true) {
                      var id = await sharedPrefrence("userId", rsp['user_id']);
                      var token =
                          await sharedPrefrence("token", rsp['access_token']);

                      var name = await sharedPrefrence("name", rsp['name']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNav()),
                      );
                      setState(() {
                        onClick = false;
                      });
                      showToast("Login Success!");
                      print("wrking");
                      print(rsp['user_id']);
                      print(rsp['access_token']);
                      print(rsp['plan_id']);
                    } else {
                      showToast("Invalid Credentials!");
                      setState(() {
                        onClick = false;
                      });
                    }
                  },
            child: Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  label,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: themeBlue),
            ),
          );
  }
}
