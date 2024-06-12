// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StoreImage {
  String? imageUrl;
  //Intance of firebaseAuth user
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // getting current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //selecting image
  Future<void> selectImage(context) async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      print(' heloo  ${file!.path}');
      if (file != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green, content: Text('Image selected')));
        await uploadImageToFirebase(File(file.path), context);
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text('Image not selected')));
    }
  }

  //uploading image to firebase storage
  Future<void> uploadImageToFirebase(
      File Imagepath, BuildContext context) async {
    try {
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('UsersProfile/${_auth.currentUser!.email}');
      await reference.putFile(Imagepath).whenComplete(() =>
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text('Image uploaded successfully'))));
      imageUrl = await reference.getDownloadURL();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Upload Failed, Try again')));
    }
  }
}
