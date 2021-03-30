import 'dart:async';
import 'package:flutter/material.dart';
import 'package:neostore_app/Screens/home_screen.dart';
import 'package:neostore_app/Screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  String finalEmail;
  @override
  void initState() {
    setState(() {
      getUserData().whenComplete(() async {
        Timer(Duration(seconds:2), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> finalEmail == null ? LoginScreen():HomeScreen())));
    });
    });

    super.initState();
  }

   getUserData() async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    setState(() {
      var obtainedEmail = loginData.getString('login');
      finalEmail = obtainedEmail;
    });
    print(finalEmail);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.red,
      body:Center(
        child:Text('NeoSTORE', style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.white,
            fontSize: 45.0),),
      ),
      );
  }
}
