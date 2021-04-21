import 'package:e_commerce/Model/Products.dart';
import 'package:e_commerce/Services/Cart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartListview extends StatefulWidget {
  @override
  _CartListviewState createState() => _CartListviewState();
}

class _CartListviewState extends State<CartListview> {
  List<ProductsModel> datalist = [];
  CustomCart cart = CustomCart();

  Future getcartdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String password = prefs.getString('password');

    DatabaseReference dbRef =
        FirebaseDatabase.instance.reference().child("Cart").child(password);
    dbRef.once().then((DataSnapshot snapshot) {
      datalist.clear();
      var keys = snapshot.value.keys;
      var values = snapshot.value;
      for (var key in keys) {
        ProductsModel model = ProductsModel(
          id: snapshot.key,
          name: values[key]['name'],
          description: values[key]['name'],
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
    getcartdata();
    super.initState();
  }

  Widget _cartitem({int index}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: () {
          setState(() {
            cart.removeFromCart(modelid: datalist[index].id);
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 5.0,
            ),
          ], borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        image: DecorationImage(
                            image: NetworkImage(
                              datalist[index].imageUrl,
                            ),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    datalist[index].name,
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        datalist[index].price + "  \$",
                        style: TextStyle(color: Colors.orange, fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: datalist.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return _cartitem(index: index);
          }),
    );
  }
}
