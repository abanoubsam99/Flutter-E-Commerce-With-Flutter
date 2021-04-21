import 'dart:io';
import 'package:e_commerce/Screens/Admin/AdminProducts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:firebase_database/firebase_database.dart';

class CustomUpload {
  Future<void> uploadMultyImages({
    @required List<File> images,
    @required String pathimage,
    @required String title,
    @required BuildContext context,
    @required String price,
    @required String description,
  }) async {
    for (var img in images) {
      firebase_storage.Reference ref;
      String filename = basename(img.path.toString());
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child(pathimage)
          .child(filename);

      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminProducts(
                        pathimage: pathimage,
                      )));

          DatabaseReference dbRef =
              FirebaseDatabase.instance.reference().child(pathimage);
          dbRef.push().set({
            'name': title,
            'price': price,
            'description': description,
            'image': [value[1]]
          });
        });
      });
    }
  }

  Future<void> uploadImage(
      {@required BuildContext context,
      @required File image,
      @required String title,
      @required String price,
      @required String description,
      @required String url,
      @required String pathimage}) async {
    firebase_storage.UploadTask uploadTask;
    firebase_storage.Reference ref;
    firebase_storage.TaskSnapshot taskSnapshot;
    String filename = basename(image.toString());

    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(pathimage)
        .child(filename);
    uploadTask = ref.putFile(image);
    taskSnapshot = uploadTask.snapshot;

    // save item info in datab se Real time
// Add Data to database

    var imgUrl = await taskSnapshot.ref.getDownloadURL();
    url = imgUrl.toString();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => AdminProducts(
                  pathimage: pathimage,
                )));

    DatabaseReference dbRef =
        FirebaseDatabase.instance.reference().child(pathimage);
    dbRef.push().set({
      'name': title,
      'price': price,
      'description': description,
      'image': url
    });
  }
}
