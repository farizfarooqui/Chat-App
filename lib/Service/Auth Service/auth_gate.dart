import 'package:chatapp/UI/Authentication%20Screens/auth_screen.dart';
import 'package:chatapp/UI/Home%20Screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            User? user = snapshot.data;
            if (user != null) {
              return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance.collection('Users').doc(user.email).get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (userSnapshot.hasData && userSnapshot.data != null) {
                    var userData = userSnapshot.data!.data();
                    String userName = userData?['fullName'] ?? 'No Name';
                    String userEmail = userData?['email'] ?? 'No Email';

                    return HomeScreen(userName: userName, userEmail: userEmail);
                  } else if (userSnapshot.hasError) {
                    return Center(child: Text('Error fetching user data'));
                  } else {
                    return AuthenticationScreen();
                  }
                },
              );
            } else {
              return AuthenticationScreen();
            }
          } else {
            return AuthenticationScreen();
          }
        },
      ),
    );
  }
}
