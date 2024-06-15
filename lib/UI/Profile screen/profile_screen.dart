// ignore_for_file: must_be_immutable
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
  String? profileUrl;
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

  updateProfile() async {
    await storeImage.selectImage(context);
    setState(() {
      widget.profileUrl = storeImage.imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: true).isDarkModeOn;
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey.shade600 : Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDarkMode ? Colors.grey.shade900 : Colors.blue.shade200,
              isDarkMode ? Colors.grey.shade900 : Colors.purple.shade200,
              isDarkMode ? Colors.grey.shade900 : Colors.purple.shade200,
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
                    color: isDarkMode ? Colors.grey.shade600 : Colors.white,
                  )),
              titleAlignment: ListTileTitleAlignment.center,
              trailing: IconButton(
                  onPressed: () {
                    logout(context);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: isDarkMode ? Colors.grey.shade600 : Colors.white,
                  )),
            ),
            GestureDetector(
              onTap: () async {
                await updateProfile();
              },
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor:
                        isDarkMode ? Colors.grey.shade600 : Colors.white,
                    backgroundImage: widget.profileUrl != null &&
                            widget.profileUrl!.isNotEmpty
                        ? NetworkImage(widget.profileUrl!)
                        : null,
                    child:
                        widget.profileUrl == null || widget.profileUrl!.isEmpty
                            ? Icon(
                                Icons.camera_alt,
                                size: 30,
                                color: isDarkMode
                                    ? Colors.grey.shade300
                                    : Colors.grey.shade300,
                              )
                            : null,
                  ),
                  Positioned(
                      right: 0,
                      top: 1,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: isDarkMode
                            ? Colors.white.withOpacity(0.2)
                            : Colors.grey.withOpacity(0.3),
                        child: Icon(
                          Icons.edit,
                          size: 24,
                          color: isDarkMode
                              ? Colors.grey.shade300
                              : Colors.grey.shade100,
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.userName,
              style: TextStyle(
                fontSize: 20,
                color: isDarkMode ? Colors.white : Colors.white,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              widget.userEmail,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.white,
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
                  color: isDarkMode ? Colors.grey.shade600 : Colors.white,
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
                        color: isDarkMode ? Colors.grey.shade600 : Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    ProfileTileWidget(
                      text: 'Settings',
                      icon: Icon(
                        Icons.settings,
                        color: isDarkMode
                            ? Colors.grey.shade600
                            : isDarkMode
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
                        color: isDarkMode ? Colors.grey.shade600 : Colors.white,
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
