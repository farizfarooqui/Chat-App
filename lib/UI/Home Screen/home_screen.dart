// ignore: unnecessary_import
// import 'dart:js';
import 'dart:js';
import 'dart:ui';
import 'package:chatapp/Service/Auth%20Service/auth_service.dart';
import 'package:chatapp/Service/Chat%20service/char_service.dart';
import 'package:chatapp/UI/Home%20Screen/Widget/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  //get chat service  instance
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Hey Fariz',
            style: TextStyle(color: Colors.blue),
          ),
          // systemOverlayStyle: const SystemUiOverlayStyle(
          //     statusBarIconBrightness: Brightness.light,
          //     statusBarColor: Colors.transparent),
          // backgroundColor: Colors.transparent,
          // shadowColor: Colors.transparent,
        ),
        drawer: const DrawerWidget(),
        body: const Center(child: Text('Hello Fariz keep the hardwork')));
  }

  // Widget _buildUserList() {
  //   return StreamBuilder(
  //       stream: _chatService.getUserStream(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasError) {
  //           return Text('data');
  //         } else if (snapshot.connectionState == ConnectionState.waiting) {
  //           return CircularProgressIndicator();
  //         } else {
  //           return ListView(
  //             children: snapshot.data!
  //                 .map<Widget>((userData) => _buildUserListItem)
  //                 .toList(),
  //           );
  //         }
  //       });
  // }

  // //build indivitual user list tile
  // Widget _buildUserListItem(
  //     Map<String, dynamic> userData, BuildContext context) {
  //   //display all users except current user
  //   return ListTile();
  // }
}
