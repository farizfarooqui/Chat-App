class ClassName {
  final String senderId;
  final String senderEmail;
  final String recieverID;
  final String message;
  final String timestamp;

  ClassName({
    required this.senderId,
    required this.senderEmail,
    required this.recieverID,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'recieverID': recieverID,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
