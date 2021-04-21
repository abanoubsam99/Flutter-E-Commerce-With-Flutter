import 'package:e_commerce/Screens/UserScreens/Homepage.dart';
import 'package:e_commerce/Screens/Auth/LoginScreen.dart';
import 'package:e_commerce/Screens/Auth/SignUpScreen.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(35),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Treva Shop",
              style: TextStyle(
                  color: Colors.white, decoration: TextDecoration.none),
            ),
            Text(
              "Get best Product in treva shop",
              style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 15),
            ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: RaisedButton(
                    color: Colors.white.withOpacity(.3),
                    child: Text(
                      "Signup",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: Text(
                    "OR SKIP",
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: 17,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: RaisedButton(
                    color: Colors.white.withOpacity(.3),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
