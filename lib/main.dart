import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/login.dart';
import 'package:weather_app/screens/profile_screen.dart';
import 'package:weather_app/screens/register.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'my_provider.dart';


void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return  ChangeNotifierProvider(
      create: (_) => MyProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'start',
        routes: {
          'start':(context) => const SplashScreen(),
          'login':(context) =>  const Login(),
          'register':(context) =>  const Register(),
          'home_screen':(context) => const HomeScreen(),
          'profile_screen':(context) => const ProfileScreen(),
        },

      ),
    );
  }


}