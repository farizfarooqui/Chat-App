// ignore: unnecessary_import
// import 'dart:js';
import 'dart:ui';
import 'package:chatapp/Auth%20Service/auth_service.dart';
import 'package:chatapp/UI/Authentication%20Screens/login_screen.dart';
import 'package:chatapp/UI/Home%20Screen/Widget/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  logout(context) async {
    final _auth = AuthService();
    await _auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginScreen()));
    print('logout');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          title: const Text(
            'Hey Fariz',
            style: TextStyle(color: Colors.orange),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarColor: Colors.transparent),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  logout(context);
                },
                icon: const Icon(Icons.logo_dev))
          ],
        ),
        drawer: DrawerWidget(),
        body: const Center(child: Text('Hello Fariz keep the hardwork')));
  }
}
