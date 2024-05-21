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
      backgroundColor: Theme.of(context).colorScheme.background,
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
        backgroundColor: isDarkMood ? Colors.transparent : Colors.blue.shade300,
        foregroundColor: Colors.grey,
        elevation: 0,
        title: Text(
          'Setting',
          style: TextStyle(
            color: isDarkMood ? Colors.grey.shade500 : Colors.white,
          ),
        ),
      ),
    );
  }
}
