import 'dart:io';

import 'package:e_commerce/Model/Products.dart';
import 'package:e_commerce/Screens/Admin/AdminProducts.dart';

import 'package:e_commerce/Services/upload.dart';
import 'package:e_commerce/Widgets/CustomTextField.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItemScreen extends StatefulWidget {
  String pathimage;
  AddItemScreen({@required this.pathimage});
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  String _title, _price, _description;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _upload = CustomUpload();
  File _image;
  // final picker = ImagePicker();
  ProductsModel model;
  String url;

// get  multy image picker
  List<File> images = [];
  final picker = ImagePicker();

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add " + widget.pathimage),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminProducts(
                          pathimage: widget.pathimage,
                        )));
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1 / 3,
                child: GridView.builder(
                    itemCount: images.length + 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (contex, index) {
                      return index == 0
                          ? Center(
                              child: IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    getimages();
                                  }),
                            )
                          : Container(
                              margin: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(images[index - 1]),
                                      fit: BoxFit.cover)),
                            );
                    }),
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                textInputType: TextInputType.name,
                hint: "Title",
                icon: Icon(Icons.title),
                secure: false,
                onclick: (value) {
                  _title = value;
                },
              ),
              CustomTextField(
                textInputType: TextInputType.number,
                hint: "Price",
                icon: Icon(Icons.monetization_on),
                secure: false,
                onclick: (value) {
                  _price = value;
                },
              ),
              CustomTextField(
                textInputType: TextInputType.text,
                hint: "Description",
                icon: Icon(Icons.description),
                secure: false,
                onclick: (value) {
                  _description = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: RaisedButton(
                  color: Colors.red.withOpacity(.3),
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    setState(() {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        _upload.uploadMultyImages(
                          context: context,
                          images: images,
                          title: _title,
                          price: _price,
                          pathimage: widget.pathimage,
                          description: _description,
                        );
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
    );
  }

// getimages
  Future<void> getimages() async {
    final pickerfile = await picker.getImage(source: ImageSource.gallery,);
    setState(() {
      images.add(File(pickerfile?.path));
    });
    if (pickerfile.path == null) retrivelostData();
  }

  Future<void> retrivelostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        images.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }
}
