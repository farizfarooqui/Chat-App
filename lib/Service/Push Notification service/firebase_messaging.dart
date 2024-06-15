import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title : ${message.notification?.title}');
  print('Body : ${message.notification?.body}');
  print('Payload : ${message.data}');
}

class firebaseMessage {
  final messaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await messaging.requestPermission();
    final fCMToken = await messaging.getToken();
    print('This is the token: $fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
