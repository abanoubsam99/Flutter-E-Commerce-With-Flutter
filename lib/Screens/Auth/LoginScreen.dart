import 'package:e_commerce/Screens/Auth/SignUpScreen.dart';
import 'package:e_commerce/Screens/Admin/AdminScreen.dart';
import 'package:e_commerce/Services/auth.dart';
import 'package:e_commerce/Widgets/CustomTextField.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Auth _auth = Auth();

  @override
  void initState() {
    // TODO: implement initState
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
              image: AssetImage("assets/images/loginbg5.jpg"),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/Shoppingcart.jpg"))),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Treva Shop",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      children: [
                        CustomTextField(
                            onclick: (value) {
                              _email = value;
                            },
                            textInputType: TextInputType.emailAddress,
                            hint: "Email",
                            icon: Icon(Icons.email),
                            secure: false),
                        CustomTextField(
                            textInputType: TextInputType.visiblePassword,
                            onclick: (value) {
                              _password = value;
                            },
                            hint: "Password",
                            icon: Icon(Icons.vpn_key),
                            secure: true),
                        FlatButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: Text(
                            "Not Have Account? Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        )
                      ],
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
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              if (_email == "Admin1234@gmail.com" &&
                                  _password == "1234567") {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdminScreen()));
                              } else {
                                _auth.signIn(
                                    password: _password,
                                    email: _email,
                                    context: context);
                              }
                            } else {
                              print("login validator error");
                            }
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
