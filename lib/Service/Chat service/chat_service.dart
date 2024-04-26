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
  Future<void> sendMessage(String recieverEmail, String message) async {
    //get the current user
    final String userId = _auth.currentUser!.uid;
    final String userEmail = _auth.currentUser!.email!;
    final Timestamp  timestamp =Timestamp.now();
  }
}
