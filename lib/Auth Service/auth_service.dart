import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  //Intance of firebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      String email, password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
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
