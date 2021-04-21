import 'package:e_commerce/Model/Products.dart';
import 'package:e_commerce/Screens/Auth/LoginScreen.dart';
import 'package:e_commerce/Screens/UserScreens/Cart.dart';
import 'package:e_commerce/Screens/UserScreens/Homepage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomCart {
  Future<void> addToCart(
      {BuildContext context,
      String name,
      String price,
      String imageUrl}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String password = prefs.getString('password');

    if (password != null) {
      DatabaseReference dbRef =
          FirebaseDatabase.instance.reference().child("Cart").child(password);
      dbRef.push().set({'name': name, 'price': price, 'image': imageUrl});
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CartScreen()));
    } else {
      loginalarm(context: context);
    }
  }

  Future<void> removeFromCart({
    String modelid,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String password = prefs.getString('password');

    DatabaseReference dbRef = FirebaseDatabase.instance
        .reference()
        .child("Cart")
        .child(password)
        .child(modelid);
    dbRef.remove();
  }

  Future<void> removeAllCart({BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String password = prefs.getString('password');

    DatabaseReference dbRef =
        FirebaseDatabase.instance.reference().child("Cart").child(password);
    dbRef.remove();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  Future<bool> loginalarm({BuildContext context}) async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('You Should login '),
            content: new Text('Do you want login now !?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen())),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
