import 'package:shared_preferences/shared_preferences.dart';

addStringToSF(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
}
getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('token');
  return stringValue;
}

removeValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Remove String
  prefs.remove("token");
}

checkKeyIsPresent() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool checkValue = prefs.containsKey('token');
  return checkValue;
}
