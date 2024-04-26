import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //Intance of firebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Intance of firebasefirestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // getting current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

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
      _firestore.collection('Users').doc(userCredential.user!.uid).set(
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

  //logout method
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
