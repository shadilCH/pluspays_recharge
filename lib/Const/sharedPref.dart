import 'package:shared_preferences/shared_preferences.dart';


final unm= "usernameRC";
final ps= "passRC";
final chek= "checkboxRC";
Future sharedPrefrence(key,data) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, data);

}


Future getSharedPrefrence(key) async {

  var prefs = await SharedPreferences.getInstance();
  var value = prefs.getString(key);

  return value;

}