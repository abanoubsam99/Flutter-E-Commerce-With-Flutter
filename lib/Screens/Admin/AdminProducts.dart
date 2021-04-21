import 'package:e_commerce/Screens/Admin/AddItemScreen.dart';
import 'package:e_commerce/Screens/Admin/AdminScreen.dart';
import 'package:e_commerce/Screens/UserScreens/TabsScreen.dart';
import 'package:flutter/material.dart';

class AdminProducts extends StatefulWidget {
  String pathimage;
  AdminProducts({@required this.pathimage});
  @override
  _AdminProductsState createState() => _AdminProductsState();
}

class _AdminProductsState extends State<AdminProducts> {
  Future<bool> _onWillPop() {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AdminScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(widget.pathimage),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AdminScreen()));
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddItemScreen(
                            pathimage: widget.pathimage,
                          )));
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
          body: TabsScreen(
            pathimage: widget.pathimage,
          )),
    );
  }
}
