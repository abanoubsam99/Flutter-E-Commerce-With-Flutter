import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';

class ProductsModel {
  String id;
  String name;
  String price;
  String description;
  String imageUrl;

  ProductsModel(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.price,
      @required this.imageUrl});

  ProductsModel.forMap(DataSnapshot dataSnapshot)
      : name = dataSnapshot.value['name'],
        price = dataSnapshot.value['price'],
        description = dataSnapshot.value['description'],
        imageUrl = dataSnapshot.value['image'];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'image': imageUrl,
    };
  }
}
