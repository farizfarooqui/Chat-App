import 'package:chatapp/Themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTileWidget extends StatelessWidget {
  final String text;
  final Widget icon;
  const ProfileTileWidget({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    bool isDarkMood =
        Provider.of<ThemeProvider>(context, listen: true).isDarkModeOn;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDarkMood ? Colors.grey.shade900 : Colors.blue.shade300,
              isDarkMood ? Colors.grey.shade900 : Colors.purple.shade300,
            ],
          ),
          borderRadius: BorderRadius.circular(20)),
      child: ListTile(
          title: Text(
            text,
            style: TextStyle(
              color: isDarkMood ? Colors.white : Colors.white,
            ),
          ),
          trailing: icon),
    );
  }
}
