import 'package:chatapp/Themes/theme_provider.dart';
import 'package:chatapp/UI/Authentication%20Screens/widgets/user_tile.dart';
import 'package:chatapp/UI/Chat%20screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/Service/Auth%20Service/auth_service.dart';
import 'package:chatapp/Service/Chat%20service/chat_service.dart';
import 'package:chatapp/UI/Home%20Screen/Widget/drawer_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final String userName;
  final String userEmail;
  HomeScreen({Key? key, required this.userName, required this.userEmail});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    bool isDarkMood =
        Provider.of<ThemeProvider>(context, listen: true).isDarkModeOn;
    return Scaffold(
      backgroundColor: isDarkMood ? Colors.grey.shade900 : Colors.white,
      appBar: AppBar(
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
          userName,
          style: TextStyle(
            color: isDarkMood ? Colors.grey.shade600 : Colors.white,
          ),
        ),
      ),
      drawer: DrawerWidget(
        userName: userName,
        userEmail: userEmail,
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          print('Data: ${snapshot.data}');
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        }
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return UserTileWidget(
        text: userData['fullName'],
        ontap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatScreen(
                recieverEmail: userData['email'],
                name: userData['fullName'],
                receiverID: userData['uid'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
