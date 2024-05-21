import 'package:chatapp/Themes/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

    // Format the timestamp
    String formattedTimestamp =
        DateFormat('hh:mm a').format(timestamp.toDate());

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? (isDarkMood ? Colors.blue.shade600 : Colors.blue.shade200)
            : (isDarkMood ? Colors.grey.shade800 : Colors.grey.shade200),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              color: isDarkMood ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
          SizedBox(
              height: 1),
          Text(
            formattedTimestamp,
            style: TextStyle(
              color: isDarkMood ? Colors.white70 : Colors.black54,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
