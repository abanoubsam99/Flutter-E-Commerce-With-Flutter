import 'dart:async';

import 'package:e_commerce/Screens/UserScreens/Homepage.dart';
import 'package:e_commerce/Screens/Auth/Welcompage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString('password');
      if (email != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Welcompage()));
      }
    });
    Firebase.initializeApp();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage("assets/images/splash.jpg"),
            fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcom To",
            style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 20),
          ),
          Text(
            "Treva Shop",
            style:
                TextStyle(color: Colors.white, decoration: TextDecoration.none),
          )
        ],
      ),
    );
  }
}
