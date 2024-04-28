import 'package:chatapp/Service/Auth%20Service/auth_service.dart';
import 'package:chatapp/Service/Chat%20service/chat_service.dart';
import 'package:chatapp/UI/Home%20Screen/Widget/message_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput()
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
          return ListView(
              children: snapshot.data!.docs
                  .map((doc) => _buildMessageItem(doc))
                  .toList());
        }
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //message alignment
    bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child: MessageTile(
            message: data['message'],
            isCurrentUser: isCurrentUser,
            timestamp: Timestamp.now()));
  }

  Widget _buildUserInput() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: TextFormField(
                controller: messageTextController,
                obscureText: false,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  hintText: 'Type your message',
                  hintStyle: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w300),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration:
                BoxDecoration(color: Colors.green, shape: BoxShape.circle),
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
