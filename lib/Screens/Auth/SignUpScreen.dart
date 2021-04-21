import 'package:e_commerce/Screens/Auth/LoginScreen.dart';
import 'package:e_commerce/Services/auth.dart';
import 'package:e_commerce/Services/validations.dart';
import 'package:e_commerce/Widgets/CustomTextField.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password, _name;
  final _auth = Auth();
  final _validation = Validations();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
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
              image: AssetImage("assets/images/loginbg1.jpg"),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 35, right: 35, top: 35),
          child: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
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
                            textInputType: TextInputType.name,
                            onclick: (value) {
                              _name = value;
                            },
                            hint: "User Name",
                            icon: Icon(Icons.person),
                            secure: false),
                        CustomTextField(
                            textInputType: TextInputType.emailAddress,
                            onclick: (value) {
                              _email = value;
                            },
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
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            "Have Account? Sign in",
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
                          "Signup",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () async {
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              try {
                                _formKey.currentState.save();
                                _auth.signUp(
                                    password: _password,
                                    email: _email,
                                    context: context);
                              } on PlatformException catch (e) {
                                print(e.message);
                              }
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
