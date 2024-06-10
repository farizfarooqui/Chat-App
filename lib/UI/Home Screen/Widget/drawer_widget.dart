import 'package:chatapp/Service/Auth%20Service/auth_service.dart';
import 'package:chatapp/Themes/theme_provider.dart';
import 'package:chatapp/UI/Authentication%20Screens/auth_screen.dart';
import 'package:chatapp/UI/Profile%20screen/profile_screen.dart';
import 'package:chatapp/UI/Settings/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  final String userName;
  final String userEmail;

  DrawerWidget({super.key, required this.userName, required this.userEmail});

  Future<void> logout(BuildContext context) async {
    final _auth = AuthService();
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AuthenticationScreen()),
    );
    print('logout');
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkModeOn;
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDarkMode ? Colors.grey.shade900 : Colors.blue.shade200,
              isDarkMode ? Colors.grey.shade900 : Colors.purple.shade200,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProfileScreen(
                        userName: userName,
                        userEmail: userEmail,
                      ),
                    ),
                  );
                },
                leading: CircleAvatar(),
                title: Text(
                  userName,
                  style: TextStyle(
                    color: isDarkMode
                        ? Colors.grey.shade200
                        : Colors.grey.shade800,
                  ),
                ),
                subtitle: Text(
                  userEmail,
                  style: TextStyle(
                    color: isDarkMode
                        ? Colors.grey.shade200
                        : Colors.grey.shade800,
                  ),
                ),
              ),
              Divider(
                indent: 20,
                endIndent: 20,
              ),
              ListTile(
                title: Text(
                  'H O M E',
                  style: TextStyle(
                    color: isDarkMode
                        ? Colors.grey.shade200
                        : Colors.grey.shade800,
                  ),
                ),
                trailing: Icon(
                  Icons.home,
                  color:
                      isDarkMode ? Colors.grey.shade200 : Colors.grey.shade800,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'S E T T I N G',
                  style: TextStyle(
                    color: isDarkMode
                        ? Colors.grey.shade200
                        : Colors.grey.shade800,
                  ),
                ),
                trailing: Icon(
                  Icons.settings,
                  color:
                      isDarkMode ? Colors.grey.shade200 : Colors.grey.shade800,
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => SettingScreen()),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'D A R K  M O D E',
                  style: TextStyle(
                    color: isDarkMode
                        ? Colors.grey.shade200
                        : Colors.grey.shade800,
                  ),
                ),
                trailing: Switch(
                  activeTrackColor: Colors.grey.shade500,
                  activeColor: Colors.grey.shade800,
                  inactiveTrackColor: Colors.blue.shade100,
                  inactiveThumbColor: Colors.blue.shade600,
                  value: Provider.of<ThemeProvider>(context).isDarkModeOn,
                  onChanged: (value) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                  },
                ),
              ),
              Spacer(),
              ListTile(
                title: Text(
                  'L O G O U T',
                  style: TextStyle(
                    color: isDarkMode
                        ? Colors.grey.shade200
                        : Colors.grey.shade800,
                  ),
                ),
                trailing: Icon(
                  Icons.logout,
                  color:
                      isDarkMode ? Colors.grey.shade200 : Colors.grey.shade800,
                ),
                onTap: () {
                  logout(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
