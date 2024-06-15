import 'package:chatapp/Service/Auth%20Service/auth_service.dart';
import 'package:chatapp/Service/Chat%20service/chat_service.dart';
import 'package:chatapp/Themes/theme_provider.dart';
import 'package:chatapp/UI/Chat%20screen/Widgets/message_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  final String recieverEmail;
  final String receiverID;
  final String name;
  ChatScreen(
      {super.key,
      required this.recieverEmail,
      required this.name,
      required this.receiverID});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageTextController = TextEditingController();

  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(Duration(milliseconds: 500), () => scrollDown());
      }
    });

    Future.delayed(Duration(milliseconds: 500), () => {scrollDown()});
  }

  @override
  void dispose() {
    focusNode.dispose();
    messageTextController.dispose();
    super.dispose();
  }

  final ScrollController _scrollDownController = ScrollController();

  scrollDown() {
    _scrollDownController.animateTo(
        _scrollDownController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn);
  }

  void sendMessage() async {
    if (messageTextController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverID, messageTextController.text);
      messageTextController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMood =
        Provider.of<ThemeProvider>(context, listen: false).isDarkModeOn;
    return Scaffold(
      backgroundColor: Colors.transparent,
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMood ? Colors.grey.shade500 : Colors.white,
          ),
        ),
        backgroundColor: isDarkMood ? Colors.transparent : Colors.blue.shade300,
        foregroundColor: Colors.grey,
        elevation: 0,
        title: Text(
          widget.name,
          style: TextStyle(
            color: isDarkMood ? Colors.grey.shade500 : Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            child: isDarkMood
                ? Image.asset(
                    'assets/images/chat/darkBg.jpg',
                    fit: BoxFit.fill,
                  )
                : Image.asset(
                    'assets/images/chat/lightBg.jpg',
                    fit: BoxFit.fill,
                  ),
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  child: _buildMessageList(),
                ),
              ),
              _buildUserInput(isDarkMood)
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(widget.receiverID, senderId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('error try again');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.purple.shade100,
          ));
        } else {
          bool isDarkMood =
              Provider.of<ThemeProvider>(context, listen: false).isDarkModeOn;
          return ListView(
              controller: _scrollDownController,
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
        color: Colors.transparent,
        alignment: alignment,
        child: MessageTile(
            message: data['message'],
            isCurrentUser: isCurrentUser,
            timestamp: data['timestamp']));
  }

  Widget _buildUserInput(isDarkMood) {
    return Container(
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
      child: Padding(
        padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                child: TextField(
                  focusNode: focusNode.parent,
                  controller: messageTextController,
                  obscureText: false,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    color: isDarkMood
                        ? Colors.grey.shade900
                        : Colors.grey.shade800,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: isDarkMood ? Colors.grey[600] : Colors.white,
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
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
            ),
            Container(
                height: 50,
                decoration: BoxDecoration(
                  color: isDarkMood ? Colors.grey.shade800 : Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            isDarkMood
                                ? Colors.grey.shade500
                                : Colors.blue.shade300,
                            isDarkMood
                                ? Colors.grey.shade500
                                : Colors.purple.shade300
                          ],
                        ).createShader(rect);
                      },
                      child: Icon(
                        Icons.play_arrow_rounded,
                        size: 36,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
