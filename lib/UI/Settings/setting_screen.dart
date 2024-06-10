import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Themes/theme_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMood =
        Provider.of<ThemeProvider>(context, listen: false).isDarkModeOn;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMood ? Colors.grey.shade500 : Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                isDarkMood ? Colors.grey.shade900 : Colors.blue.shade200,
                isDarkMood ? Colors.grey.shade900 : Colors.purple.shade200,
              ],
            ),
          ),
        ),
        elevation: 0,
        title: Text(
          'Setting',
          style: TextStyle(
            color: isDarkMood ? Colors.grey.shade500 : Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDarkMood ? Colors.grey.shade900 : Colors.blue.shade200,
              isDarkMood ? Colors.grey.shade900 : Colors.purple.shade200,
            ],
          ),
        ),
      ),
    );
  }
}
