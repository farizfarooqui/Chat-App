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
  final String? profileUrl;

  DrawerWidget(
      {super.key,
      required this.userName,
      required this.userEmail,
      this.profileUrl});

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
                        profileUrl: profileUrl,
                      ),
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundColor:
                      isDarkMode ? Colors.grey.shade600 : Colors.grey.shade100,
                  backgroundImage: profileUrl != null && profileUrl!.isNotEmpty
                      ? NetworkImage(profileUrl!)
                      : null,
                ),
                title: Text(
                  userName,
                  style: TextStyle(
                    letterSpacing: 2,
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
                  Navigator.push(
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
                  inactiveThumbColor: Colors.purple.shade200,
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
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
