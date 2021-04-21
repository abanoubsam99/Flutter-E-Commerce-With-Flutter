import 'package:e_commerce/Model/Products.dart';
import 'package:e_commerce/Widgets/GridViewProduct.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  String pathimage;
  TabsScreen({@required this.pathimage});
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
// get data
  List<ProductsModel> datalist = [];
  Future getdata() {
    DatabaseReference dbRef =
        FirebaseDatabase.instance.reference().child(widget.pathimage);
    dbRef.once().then((DataSnapshot snapshot) {
      datalist.clear();
      var keys = snapshot.value.keys;
      var values = snapshot.value;
      for (var key in keys) {
        ProductsModel model = ProductsModel(
          id: snapshot.key,
          name: values[key]['name'],
          description: values[key]['description'],
          imageUrl: values[key]['image'],
          price: values[key]['price'],
        );
        datalist.add(model);
        //to make refresh
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    Firebase.initializeApp();
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: datalist.length == 0
          ? Center(
              child: Text(
              "No Data",
              style: TextStyle(color: Colors.orange[600], fontSize: 25),
            )
              /*
              CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[600]),
            )
            */
              )
          : CustomGridViewProduct(
              pathimage: widget.pathimage,
            ),
    );
  }
}
