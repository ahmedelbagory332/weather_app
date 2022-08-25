import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Utils.dart';
import 'package:weather_app/shared_preferences.dart';
import '../firebase_helper/fireBaseHelper.dart';
import '../my_provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String country = "";
  String weather = "";
 bool isLoading = true;
  Future<void> getWeather(String country) async {
    var postUrl = 'https://api.weatherapi.com/v1/current.json?key=5a29fbab4c114f32840192828222408&q=$country';
    Dio dio = Dio();

    try{
      final response = await dio.get(postUrl);
      setState(() {
        country = response.data["location"]["country"];
        weather = "${response.data["current"]["temp_c"]} °C";
        isLoading = false;
      });

    }catch(e){
      // in case county name is wrong
      buildShowSnackBar(context, "Please Check Your Country Name");
      debugPrint('Error : $e');
    }


  }

  @override
  void initState() {
    super.initState();
    Country.getCountry().then((value){
      setState(() {
        country = value;
        getWeather(country);
      });
    });

  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  FireBaseHelper().signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      'login', (Route<dynamic> route) => false);
                },
                icon: const Icon(Icons.logout_sharp)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('profile_screen');
                },
                icon: const Icon(Icons.person))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Center(child: Text(country.isEmpty?"Update your country Info in your profile":isLoading?"getting your country weather":"Your Current Weather in $country is $weather")),
            ),
            ElevatedButton(
                onPressed: (){
                  Country.getCountry().then((value){
                    if(value.isEmpty){
                      buildShowSnackBar(context, "Go to your profile and add your country");
                    }else{
                      setState(() {
                        country = value;
                        isLoading = true;
                      });
                      getWeather(country);
                    }
                  });

                },
                child: const Text("Get Your Country Weather"))


          ],
        ),
      ),
    );
  }
}