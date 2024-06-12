// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:chatapp/Service/Auth%20Service/auth_service.dart';
import 'package:chatapp/Service/Upload%20image%20service/upload_image_service.dart';
import 'package:chatapp/Themes/theme_provider.dart';
import 'package:chatapp/UI/Authentication%20Screens/auth_screen.dart';
import 'package:chatapp/UI/Common%20widgets/personal_details_widget.dart';
import 'package:chatapp/UI/Common%20widgets/tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String? profileUrl;
  String? imagePath;

  ProfileScreen(
      {super.key,
      required this.userName,
      required this.userEmail,
      this.imagePath,
      this.profileUrl});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  logout(context) async {
    final _auth = AuthService();
    await _auth.signOut();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => const AuthenticationScreen()));
    print('logout');
  }

  StoreImage storeImage = StoreImage();

  @override
  Widget build(BuildContext context) {
    bool isDarkMood =
        Provider.of<ThemeProvider>(context, listen: true).isDarkModeOn;
    return Scaffold(
      backgroundColor: isDarkMood ? Colors.grey.shade600 : Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDarkMood ? Colors.grey.shade900 : Colors.blue.shade200,
              isDarkMood ? Colors.grey.shade900 : Colors.purple.shade200,
              isDarkMood ? Colors.grey.shade900 : Colors.purple.shade200,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
            ),
            ListTile(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: isDarkMood ? Colors.grey.shade600 : Colors.white,
                  )),
              titleAlignment: ListTileTitleAlignment.center,
              trailing: IconButton(
                  onPressed: () {
                    logout(context);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: isDarkMood ? Colors.grey.shade600 : Colors.white,
                  )),
            ),
            GestureDetector(
              onTap: () async {
                await storeImage.selectImage(context);
                setState(() {});
              },
              child: CircleAvatar(
                radius: 60,
                backgroundColor:
                    isDarkMood ? Colors.grey.shade600 : Colors.white,
                backgroundImage: storeImage.imageUrl != null &&
                        storeImage.imageUrl!.isNotEmpty
                    ? NetworkImage(storeImage.imageUrl!)
                    : null,
                child: storeImage.imageUrl == null
                    ? Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: isDarkMood
                            ? Colors.grey.shade300
                            : Colors.grey.shade300,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.userName,
              style: TextStyle(
                fontSize: 20,
                color: isDarkMood ? Colors.white : Colors.white,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              widget.userEmail,
              style: TextStyle(
                color: isDarkMood ? Colors.white : Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 24,
                  right: 24,
                ),
                decoration: BoxDecoration(
                  color: isDarkMood ? Colors.grey.shade600 : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    PersonalDetailsWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    ProfileTileWidget(
                      text: 'Change Password',
                      icon: Icon(
                        Icons.lock,
                        color: isDarkMood ? Colors.grey.shade600 : Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    ProfileTileWidget(
                      text: 'Settings',
                      icon: Icon(
                        Icons.settings,
                        color: isDarkMood
                            ? Colors.grey.shade600
                            : isDarkMood
                                ? Colors.grey.shade600
                                : Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    ProfileTileWidget(
                      text: 'Chats',
                      icon: Icon(
                        Icons.message,
                        color: isDarkMood ? Colors.grey.shade600 : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
