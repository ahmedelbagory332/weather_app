import 'package:shared_preferences/shared_preferences.dart';

class Country {
  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static saveCountry(String country) async {
    SharedPreferences pref = await _prefs;
    pref.setString("country", country)
        .then((value) => print('Value Saved : $value'));
  }

  static Future<String> getCountry() async {
    SharedPreferences pref = await _prefs;
    return pref.getString("country")??"";
  }
}


