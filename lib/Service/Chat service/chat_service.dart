import 'dart:async';
import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  //instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //go thorough each individual user
        final user = doc.data();
        //return user
        return user;
      }).toList();
    });
  }

  //send msg
  Future<void> sendMessage(String receiverID, String message) async {
    //get the current user
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    //contructing chat room id for two users
    List<String> id = [receiverID, currentUserId];
    id.sort();
    String chatroomId = id.join("-");

    await _firestore
        .collection('Chat-rooms')
        .doc(chatroomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //getting message
  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    //construct a chatroom id for twto users
    List ids = [userId, otherUserId];
    ids.sort();
    String chatroomId = ids.join('-');

    return _firestore
        .collection('Chat-rooms')
        .doc(chatroomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getRecentMessages(String userId) {
    return _firestore
        .collection('Messages')
        .where('receiverId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots();
  }
}
