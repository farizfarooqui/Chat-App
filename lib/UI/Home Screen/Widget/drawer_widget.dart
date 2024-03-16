import 'package:chatapp/Service/Auth%20Service/auth_service.dart';
import 'package:chatapp/UI/Authentication%20Screens/login_screen.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});
  logout(context) async {
    final _auth = AuthService();
    await _auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    print('logout');
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.amber,
                  ),
                ),
                ListTile(
                  title: Text('H O M E'),
                  trailing: Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('S E T T I N G'),
                  trailing: Icon(Icons.settings),
                  onTap: () {
        //             Navigator.pushReplacement(
        // context, MaterialPageRoute(builder: (_) => LoginScreen()));
                  },
                ),
                ListTile(
                  title: Text('A B O U T'),
                  trailing: Icon(Icons.warning_amber_outlined),
                  onTap: () {
                  },
                ),
                Spacer(),
                ListTile(
                  title: Text('L O G O U T'),
                  trailing: Icon(Icons.logout),
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