import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/shared_preferences.dart';

class MyProvider with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String country = "";

  Future<void> getMyCountry() async {
    await Country.getCountry();
    notifyListeners();
  }



}