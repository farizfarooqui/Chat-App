import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthService {
  //Intance of firebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Intance of firebasefirestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // getting current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
 // Instance of FirebaseStorage
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // login method
  Future<UserCredential> signInWithEmailAndPassword(
      String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> getUserName() async {
    try {
      DocumentSnapshot snapshot = await _firestore
          .collection('Users')
          .doc(_auth.currentUser!.uid)
          .get();
      if (snapshot.exists) {
        return snapshot['fullName'];
      } else {
        return 'User';
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //Sign up method
  Future<UserCredential> registerWithEmailAndPasword(
      String email, password, String name) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //storing data in firebase
      _firestore.collection('Users').doc(email).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
          'fullName': name,
        },
      );
      return userCredential;
    } catch (e) {
      throw Exception(e);
    }
  }
    // Upload photo and save URL to Firestore
  Future<void> uploadPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File file = File(pickedFile.path);

      try {
        String uid = _auth.currentUser!.uid;
        TaskSnapshot snapshot = await _storage.ref().child('user_photos/$uid').putFile(file);
        String downloadUrl = await snapshot.ref.getDownloadURL();

        await _firestore.collection('Users').doc(uid).update({'photoUrl': downloadUrl});
      } catch (e) {
        throw Exception(e);
      }
    } else {
      throw Exception('No image selected');
    }
  }

  //logout method
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
