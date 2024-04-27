import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 4),
      padding: EdgeInsets.only(right: 15, left: 15),
      decoration: BoxDecoration(
          color: isCurrentUser ? Colors.green : Colors.grey[200],
          borderRadius: BorderRadius.circular(6)),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                child: Text(
                  message,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Text('')
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Text('9:04'),
          )
        ],
      ),
    );
  }
}
