import 'package:chatapp/Themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTileWidget extends StatelessWidget {
  final String text;
  final void Function()? ontap;
  const UserTileWidget({
    super.key,
    required this.text,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMood =
        Provider.of<ThemeProvider>(context, listen: false).isDarkModeOn;
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
        child: ListTile(
          tileColor: isDarkMood ? Colors.grey.shade800 : Colors.grey.shade100,
          leading: CircleAvatar(
            backgroundColor:
                isDarkMood ? Colors.grey.shade400 : Colors.purple.shade100,
            child: Icon(
              Icons.person,
              color: isDarkMood ? Colors.grey.shade600 : Colors.grey.shade100,
            ),
          ),
          title: Text(
            text,
            style: TextStyle(
                color:
                    isDarkMood ? Colors.grey.shade200 : Colors.grey.shade800),
          ),
        ),
      ),
    );
  }
}
