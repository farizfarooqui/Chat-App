import 'package:chatapp/Themes/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final Timestamp timestamp;
  MessageTile({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMood =
        Provider.of<ThemeProvider>(context, listen: false).isDarkModeOn;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
      padding: EdgeInsets.only(right: 15, left: 15),
      decoration: BoxDecoration(
          color: isCurrentUser
              ? (isDarkMood ? Colors.green.shade600 : Colors.green.shade500)
              : (isDarkMood ? Colors.grey.shade800 : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(6)),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                child: Text(
                  message,
                  style: TextStyle(
                      color: (isDarkMood ? Colors.white : Colors.black),
                      fontSize: 20),
                ),
              ),
              Text('')
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Text(
              '9:04',
              style: TextStyle(
                color: (isDarkMood ? Colors.white : Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
