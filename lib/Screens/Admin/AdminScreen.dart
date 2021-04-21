import 'package:e_commerce/Screens/Admin/AdminProducts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  Widget _itemProductMain({String pathimage, String image}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdminProducts(
                      pathimage: pathimage,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.2),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 25,
              right: 25,
              child: Text(
                pathimage,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _tabitems = [
    {
      'name': "T-shirt",
      'image':
          "https://image.freepik.com/free-psd/girl-t-shirt-mock-up_89887-80.jpg"
    },
    {
      'name': "Sweater",
      'image':
          "https://image.freepik.com/free-photo/young-beautiful-brunette-girl-knitted-sweater-christmas-hat-smiling-blue-wall_176420-11629.jpg"
    },
    {
      'name': " Jacket",
      'image':
          "https://image.freepik.com/free-photo/attractive-stylish-woman-leather-jacket-smiling_176420-17772.jpg"
    },
    {
      'name': "Coat",
      'image':
          "https://img.freepik.com/free-photo/business-woman-happy-coat-street_1303-11842.jpg?size=626&ext=jpg"
    },
    {
      'name': "Jeans",
      'image':
          "https://image.freepik.com/free-photo/cheerful-woman-jeans-hat-sunglasses-smiling-camera_171337-12136.jpg"
    },
    {
      'name': "Shorts",
      'image':
          "https://img.freepik.com/free-photo/pretty-happy-girl-striped-t-shirt-jeans-shorts-posing-with-glasses-beach_273443-1151.jpg?size=338&ext=jpg"
    },
    {
      'name': "Tracksuit",
      'image':
          "https://image.freepik.com/free-photo/outdoor-yoga_23-2148077583.jpg"
    }
  ];

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
          title: Text("Treva Shop Admin"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                    itemCount: 7,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15),
                    itemBuilder: (ctx, index) {
                      return _itemProductMain(
                          pathimage: _tabitems[index]['name'],
                          image: _tabitems[index]['image']);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
