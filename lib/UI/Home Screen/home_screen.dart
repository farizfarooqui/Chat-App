import 'package:flutter/material.dart';
import 'package:chatapp/Service/Auth%20Service/auth_service.dart';
import 'package:chatapp/Service/Chat%20service/char_service.dart';
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
          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        }
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), 
      ),
      child: ListTile(
        onTap: () {
        },
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.person),
        ),
        title: Text(userData['name']),
        subtitle: Text(userData['email']),
      ),
    );
  }
}
