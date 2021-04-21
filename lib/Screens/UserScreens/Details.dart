import 'package:e_commerce/Model/Products.dart';
import 'package:e_commerce/Screens/Auth/LoginScreen.dart';
import 'package:e_commerce/Screens/UserScreens/Cart.dart';
import 'package:e_commerce/Services/Cart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetails extends StatefulWidget {
  final ProductsModel model;
  ProductDetails({@required this.model});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  CustomCart cart;

  @override
  void initState() {
    cart = CustomCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 3 / 5,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.model.imageUrl),
                  fit: BoxFit.cover),
              color: Colors.white,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 3 / 5 - 50,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 2 / 5 + 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.model.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                        Text(
                          widget.model.price + " \$",
                          style: TextStyle(
                              color: Colors.orange[600],
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Text("Product Description ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(widget.model.description,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 13)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        cart.addToCart(
                            context: context,
                            name: widget.model.name,
                            imageUrl: widget.model.imageUrl,
                            price: widget.model.price);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Center(
                          child: Text("Add To Cart",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 20,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25,
                ),
              ))
        ],
      ),
    );
  }
}
