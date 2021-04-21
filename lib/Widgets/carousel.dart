import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  "assets/images/loginbg2.jpg",
  "assets/images/loginbg3.jpg",
  "assets/images/loginbg4.jpg",
  "assets/images/loginbg5.jpg"
];

class CustomCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            height: MediaQuery.of(context).size.height,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            // autoPlay: false,
          ),
          items: imgList
              .map((item) => Container(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            colorFilter: new ColorFilter.mode(
                                Colors.white.withOpacity(0.7),
                                BlendMode.dstATop),
                            image: AssetImage(item),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ))
              .toList(),
        ));
  }
}

// carousel_slider
final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  image: AssetImage(item),
                  fit: BoxFit.cover),
            ),
          ),
        ))
    .toList();
