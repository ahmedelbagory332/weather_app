import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Utils.dart';
import 'package:weather_app/my_provider.dart';
import 'package:weather_app/shared_preferences.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  String name = "";
  String email = "";
  String password = "";
  String country = "";
  bool changeName = false;
  bool changeEmail = false;
  bool changePassword = false;
  bool changeCountry = false;

@override
void initState() {
  super.initState();
    Country.getCountry().then((value){
      setState(() {
        name = Provider.of<MyProvider>(context,listen: false).auth.currentUser!.displayName!;
        email = Provider.of<MyProvider>(context,listen: false).auth.currentUser!.email!;
        country = value;
      });
    });



}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Profile"),
          
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children:  [
              Row(
                children: [
                  const Text("Name : ",style: TextStyle(fontWeight: FontWeight.bold),),
                  changeName?SizedBox(
                    width: 150,
                    child: TextField(
                        onChanged: (text) {
                         name = text;
                        },
                    ),
                  )
                      :Text(name),
                  IconButton(
                      onPressed: () {
                      setState(() {
                        if(name.isEmpty){
                          return;
                        }else{
                          Provider.of<MyProvider>(context,listen: false).auth.currentUser!.updateDisplayName(name);

                        }
                        changeName = !changeName;
                      });
                      },
                      icon: Icon(changeName?Icons.add:Icons.edit))
                ],
              ),
              Row(
                children: [
                  const Text("Email : ",style: TextStyle(fontWeight: FontWeight.bold),),
                  changeEmail?SizedBox(
                    width: 150,
                    child: TextField(
                      onChanged: (text) {
                        email = text;
                      },
                    ),
                  ) :Text(email),
                  IconButton(
                      onPressed: () {

                          setState(() {
                            if(email.isEmpty){
                              return;
                            }else{
                              Provider.of<MyProvider>(context,listen: false).auth.currentUser!.updateEmail(email)
                                  .catchError((error, stackTrace){
                                buildShowSnackBar(context, error.toString());
                              });
                              changeEmail = !changeEmail;
                            }
                          });



                      },
                      icon: Icon(changeEmail?Icons.add:Icons.edit))
                ],
              ),
              Row(
                children: [
                  changePassword?SizedBox(
                    width: 150,
                    child: TextField(
                      onChanged: (text) {
                        password = text;
                      },
                    ),
                  ) : const Text("Change My Password",style: TextStyle(fontWeight: FontWeight.bold),),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          changePassword = !changePassword;
                          if(password.isEmpty){

                          }else{
                            Provider.of<MyProvider>(context,listen: false).auth.currentUser!.updatePassword(password)
                                .catchError((error, stackTrace){
                              buildShowSnackBar(context, error.toString());
                            });
                          }
                        });
                        password = "";
                      },
                      icon: Icon(changePassword?Icons.add:Icons.edit))
                ],
              ),
              Row(
                children: [
                  const Text("MY country : ",style: TextStyle(fontWeight: FontWeight.bold),),
                  changeCountry?SizedBox(
                    width: 150,
                    child: TextField(
                      onChanged: (text) {
                        country = text;
                      },
                    ),
                  )
                      :Text(country.isEmpty?"Tap to add your country":country),
                  IconButton(
                      onPressed: () async{
                        setState(() {
                          changeCountry = !changeCountry;
                        });
                        if(country.isEmpty){
                        }
                        else{
                          await Country.saveCountry(country);
                          setState(() {
                            country = country;
                          });
                        }

                      },
                      icon: Icon(changeCountry?Icons.add:Icons.edit))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}