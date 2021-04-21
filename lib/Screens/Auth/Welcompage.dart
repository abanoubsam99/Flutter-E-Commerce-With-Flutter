import 'package:e_commerce/Widgets/carousel.dart';
import 'package:e_commerce/Widgets/HomeBody.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Welcompage extends StatelessWidget {
  @override
  void initState() {
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [CustomCarousel(), HomeBody()],
    );
  }
}
