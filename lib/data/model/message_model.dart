/// A model for a message in the chat.
class MessageModel {
  /// The ID of the sender of the message.
  final String senderId;

  /// The name of the sender of the message.
  final String sendername;

  /// The email of the sender of the message.
  final String senderEmail;

  /// The ID of the receiver of the message.
  final String receiverId;

  /// The message content.
  final String message;

  /// The timestamp of the message.
  final DateTime timestamp;

  /// Create a new message model.
  MessageModel({
    required this.senderId,
    required this.sendername,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  /// Convert the message model to a map.
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'sendername': sendername,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
