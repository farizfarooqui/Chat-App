import 'package:chatapp/Service/Auth%20Service/auth_service.dart';
import 'package:chatapp/Service/Chat%20service/chat_service.dart';
import 'package:chatapp/Themes/theme_provider.dart';
import 'package:chatapp/UI/Chat%20screen/Widgets/message_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  final String recieverEmail;
  final String receiverID;
  final String name;
  ChatScreen(
      {super.key,
      required this.recieverEmail,
      required this.name,
      required this.receiverID});

  TextEditingController messageTextController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if (messageTextController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, messageTextController.text);
      messageTextController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMood =
        Provider.of<ThemeProvider>(context, listen: false).isDarkModeOn;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMood ? Colors.grey.shade500 : Colors.white,
          ),
        ),
        backgroundColor: isDarkMood ? Colors.transparent : Colors.blue.shade300,
        foregroundColor: Colors.grey,
        elevation: 0,
        title: Text(
          name,
          style: TextStyle(
            color: isDarkMood ? Colors.grey.shade500 : Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                color: isDarkMood ? Colors.grey.shade900 : Colors.blue.shade100,
                child: _buildMessageList()),
          ),
          _buildUserInput(isDarkMood)
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(receiverID, senderId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('error try again');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          bool isDarkMood =
              Provider.of<ThemeProvider>(context, listen: false).isDarkModeOn;
          return ListView(
              children: snapshot.data!.docs
                  .map((doc) => _buildMessageItem(doc, isDarkMood))
                  .toList());
        }
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc, isDarkMood) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //message alignment
    bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        color: isDarkMood ? Colors.grey.shade900 : Colors.blue.shade100,
        alignment: alignment,
        child: MessageTile(
            message: data['message'],
            isCurrentUser: isCurrentUser,
            timestamp: data['timestamp']
            ));
  }

  Widget _buildUserInput(isDarkMood) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 8),
              child: TextFormField(
                style: TextStyle(
                  color:
                      isDarkMood ? Colors.grey.shade900 : Colors.grey.shade800,
                ),
                controller: messageTextController,
                obscureText: false,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDarkMood ? Colors.grey[600] : Colors.blue[100],
                  hintText: 'Type your message',
                  hintStyle: TextStyle(
                    color: isDarkMood
                        ? Colors.grey.shade900
                        : Colors.grey.shade800,
                    fontWeight: FontWeight.w300,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: isDarkMood ? Colors.transparent : Colors.white,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: isDarkMood ? Colors.grey.shade800 : Colors.blue.shade700,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: sendMessage,
              icon: Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
