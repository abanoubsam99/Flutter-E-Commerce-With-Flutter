import 'package:e_commerce/Screens/Admin/AddItemScreen.dart';
import 'package:e_commerce/Screens/Auth/SplashScreen.dart';
import 'package:e_commerce/Screens/Admin/AdminProducts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
