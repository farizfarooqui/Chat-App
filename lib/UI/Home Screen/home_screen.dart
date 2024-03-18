import 'package:chatapp/UI/Authentication%20Screens/widgets/user_tile.dart';
import 'package:chatapp/UI/Home%20Screen/Chat%20screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/Service/Auth%20Service/auth_service.dart';
import 'package:chatapp/Service/Chat%20service/chat_service.dart';
import 'package:chatapp/UI/Home%20Screen/Widget/drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hey Fariz',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      drawer: const DrawerWidget(),
      body: _buildUserList(), // Include _buildUserList() here
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
    print('object user data $userData');
    return UserTileWidget(
      text: userData['email'],
      ontap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ChatScreen(
                      recieverEmail: userData['email'],
                    )));
      },
    );
  }
}
