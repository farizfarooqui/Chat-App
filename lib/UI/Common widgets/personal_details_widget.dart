import 'package:chatapp/Constant/app_colors.dart';
import 'package:chatapp/Themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalDetailsWidget extends StatelessWidget {
  const PersonalDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMood =
        Provider.of<ThemeProvider>(context, listen: true).isDarkModeOn;
    return Container(
      padding: const EdgeInsets.all(10),
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
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: Text(
              'Developer Details',
              style: TextStyle(
                fontSize: 16,
                color: isDarkMood ? Colors.grey.shade600 : Colors.white,
              ),
            ),
          ),
          Divider(
            color: isDarkMood ? Colors.grey.shade600 : Colors.white,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Email',
                  style: TextStyle(
                    color: isDarkMood ? Colors.grey.shade600 : Colors.white,
                  ),
                ),
                Spacer(),
                Text(
                  'fariizfarooqui104@gmail.com',
                  style: TextStyle(
                    color: isDarkMood ? Colors.grey.shade600 : Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Divider(
            color: isDarkMood ? Colors.grey.shade600 : Colors.white,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Date of Birth',
                  style: TextStyle(
                    color: isDarkMood ? Colors.grey.shade600 : Colors.white,
                  ),
                ),
                Spacer(),
                Text(
                  '02.11.2002',
                  style: TextStyle(
                    color: isDarkMood ? Colors.grey.shade600 : Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Divider(
            color: isDarkMood ? Colors.grey.shade600 : Colors.white,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Gender',
                  style: TextStyle(
                    color: isDarkMood ? Colors.grey.shade600 : Colors.white,
                  ),
                ),
                Spacer(),
                Text(
                  'Male',
                  style: TextStyle(
                    color: isDarkMood ? Colors.grey.shade600 : Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Divider(
            color: isDarkMood ? Colors.grey.shade600 : Colors.white,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Phone',
                  style: TextStyle(
                    color: isDarkMood ? Colors.grey.shade600 : Colors.white,
                  ),
                ),
                Spacer(),
                Text(
                  '03133017289',
                  style: TextStyle(
                    color: isDarkMood ? Colors.grey.shade600 : Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
