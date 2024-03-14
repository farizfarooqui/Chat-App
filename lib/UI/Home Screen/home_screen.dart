// ignore: unnecessary_import
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        ),
        body: const Center(child: Text('Hello Fariz keep the hardwork')));
  }
}
