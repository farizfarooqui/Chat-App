import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  //instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
}
