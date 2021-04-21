import 'package:e_commerce/Model/Products.dart';
import 'package:e_commerce/Screens/UserScreens/Cart.dart';
import 'package:e_commerce/Screens/UserScreens/TabsScreen.dart';
import 'package:e_commerce/Services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final Auth _auth = Auth();
  TabController _tabController;
  List<String> _tabtitle = [
    "T-shirt",
    "Sweater",
    " Jacket",
    "Coat",
    "Jeans",
    "Shorts",
    "Tracksuit"
  ];

  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("Tshirt");
// get data
  List<ProductsModel> datalist = [];
  Future getdata() {
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
    _tabController = TabController(length: _tabtitle.length, vsync: this);
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => SystemNavigator.pop(),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Treva Shop",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: false,
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/Shoppingcart.jpg",
                      ),
                      fit: BoxFit.cover)),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                size: 25,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                size: 25,
                color: Colors.black,
              ),
              onPressed: () {
                _auth.signOut(context: context);
              },
            ),
            SizedBox(
              width: 10,
            ),
          ],
          bottom: TabBar(
            tabs: _tabtitle.map((String name) => Tab(text: name)).toList(),
            controller: _tabController,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            isScrollable: true,
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
            unselectedLabelStyle: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2.5,
          ),
        ),
        body: TabBarView(controller: _tabController, children: [
          TabsScreen(
            pathimage: "T-shirt",
          ),
          TabsScreen(
            pathimage: "Sweater",
          ),
          TabsScreen(
            pathimage: " Jacket",
          ),
          TabsScreen(
            pathimage: "Coat",
          ),
          TabsScreen(
            pathimage: "Jeans",
          ),
          TabsScreen(
            pathimage: "Shorts",
          ),
          TabsScreen(
            pathimage: "Tracksuit",
          ),
        ]),
      ),
    );
  }
}
