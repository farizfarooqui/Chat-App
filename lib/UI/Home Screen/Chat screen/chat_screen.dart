import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String recieverEmail;
  final String name;
  const ChatScreen(
      {super.key, required this.recieverEmail, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
    );
  }
}
