import 'package:shared_preferences/shared_preferences.dart';

class SetSharedPrefValue {
  setSignupValue(value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('signupValue', value);
  }
}