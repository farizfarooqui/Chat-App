import 'package:chatapp/Service/Auth%20Service/auth_service.dart';
import 'package:chatapp/Themes/theme_provider.dart';
import 'package:chatapp/UI/Authentication%20Screens/auth_screen.dart';
import 'package:chatapp/UI/Settings/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});
  logout(context) async {
    final _auth = AuthService();
    await _auth.signOut();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => const AuthenticationScreen()));
    print('logout');
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMood =
        Provider.of<ThemeProvider>(context, listen: false).isDarkModeOn;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(),
            ),
            ListTile(
              title: Text(
                'H O M E',
                style: TextStyle(
                    color: isDarkMood
                        ? Colors.grey.shade200
                        : Colors.grey.shade800),
              ),
              trailing: Icon(
                Icons.home,
                color: isDarkMood ? Colors.grey.shade200 : Colors.grey.shade800,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'S E T T I N G',
                style: TextStyle(
                    color: isDarkMood
                        ? Colors.grey.shade200
                        : Colors.grey.shade800),
              ),
              trailing: Icon(
                Icons.settings,
                color: isDarkMood ? Colors.grey.shade200 : Colors.grey.shade800,
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => SettingScreen()));
              },
            ),
            ListTile(
                title: Text(
                  'D A R K  M O D E',
                  style: TextStyle(
                      color: isDarkMood
                          ? Colors.grey.shade200
                          : Colors.grey.shade800),
                ),
                trailing: Switch(
                  activeTrackColor: Colors.grey.shade500,
                  activeColor: Colors.grey.shade800,
                  inactiveTrackColor: Colors.grey.shade500,
                  inactiveThumbColor: Colors.grey.shade200,
                  value: Provider.of<ThemeProvider>(context, listen: false)
                      .isDarkModeOn,
                  onChanged: ((value) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                  }),
                )),
            Spacer(),
            ListTile(
              title: Text(
                'L O G O U T',
                style: TextStyle(
                    color: isDarkMood
                        ? Colors.grey.shade200
                        : Colors.grey.shade800),
              ),
              trailing: Icon(
                Icons.logout,
                color: isDarkMood ? Colors.grey.shade200 : Colors.grey.shade800,
              ),
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
