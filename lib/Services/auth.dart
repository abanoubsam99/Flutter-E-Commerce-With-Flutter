import 'package:e_commerce/Screens/UserScreens/Homepage.dart';
import 'package:e_commerce/Screens/Auth/SplashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(
      {String email, String password, BuildContext context}) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('password', password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }).catchError((e) {
      print(e.message);
    });
  }

  Future<void> signIn(
      {String email, String password, BuildContext context}) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('password', password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }).catchError((e) {
      print(e.message);
    });
  }

  Future<void> signOut({BuildContext context}) async {
    await _auth.signOut().then((user) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('password');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SplashScreen()));
    }).catchError((e) {
      print(e.message);
    });
  }
}
