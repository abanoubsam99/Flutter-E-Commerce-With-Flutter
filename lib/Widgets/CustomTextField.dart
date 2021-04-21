import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  String hint;
  bool secure;
  Widget icon;
  TextInputType textInputType;
  final Function onclick;
  String _errorMessage(String error) {
    switch (hint) {
      case "User Name":
        return "User Name is empty";
      case "Email":
        return " Email is empty";
      case "Password":
        return " Password is empty";
      case "Price":
        return " Price is empty";
      case "Title":
        return " Title is empty";
      case "Description":
        return " Description is empty";
    }
  }

  CustomTextField({
    @required this.hint,
    @required this.icon,
    @required this.secure,
    @required this.onclick,
    @required this.textInputType,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return _errorMessage(hint);
              }
            },
            onSaved: onclick,
            obscureText: secure,
            keyboardType: textInputType,
            decoration: InputDecoration(
                hintText: hint,
                fillColor: Colors.white,
                filled: true,
                prefixIcon: icon,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
        ),
      ),
    );
  }
}
