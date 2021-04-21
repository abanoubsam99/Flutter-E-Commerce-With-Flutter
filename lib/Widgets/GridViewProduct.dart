import 'package:e_commerce/Model/Products.dart';
import 'package:e_commerce/Screens/UserScreens/Details.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CustomGridViewProduct extends StatefulWidget {
  String pathimage;
  CustomGridViewProduct({@required this.pathimage});
  @override
  _CustomGridViewProductState createState() => _CustomGridViewProductState();
}

class _CustomGridViewProductState extends State<CustomGridViewProduct> {
  String id;
  String title;
  String price;
  String description;
  String url;

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

  Widget _productItem({int index}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetails(
                      model: datalist[index],
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 2.0,
                    ),
                  ],
                  image: DecorationImage(
                      image: NetworkImage(
                        datalist[index].imageUrl,
                      ),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      datalist[index].name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    datalist[index].price + " \$",
                    style: TextStyle(color: Colors.orange[600], fontSize: 17),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                  itemCount: datalist.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 10),
                  itemBuilder: (ctx, index) {
                    return _productItem(index: index);
                  }),
            ),
          )
        ],
      ),
    );
  }
}
