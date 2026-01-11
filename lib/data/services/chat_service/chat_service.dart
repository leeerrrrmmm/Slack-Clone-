import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:slaac/data/model/message_model.dart';

/// ChatService is the service that handles the chat functionality.
class ChatService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///Send a message to a user.
  Future<void> sendMessage(String receiverId, String message) async {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      throw Exception('No authenticated user found');
    }

    final String curUserId = currentUser.uid;
    final String curUserEmail = currentUser.email ?? 'unknown@gmail.com';
    final curUserName = currentUser.displayName;
    final Timestamp timestamp = Timestamp.now();

    ///Create a new message
    final messageModel = MessageModel(
      senderId: curUserId,
      sendername: curUserName ?? 'unknown',
      senderEmail: curUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp.toDate(),
    );

    ///Create chat room ID for two users
    final List<String> ids = [curUserId, receiverId];
    ids.sort();
    final String chatRoomId = ids.join('_');

    ///Save message to firebase
    await _firestore
        .collection('ChatRooms')
        .doc(chatRoomId)
        .collection('Messages')
        .add(messageModel.toMap());
  }

  ///Get stream of messages between two users
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    final List<String> ids = [userId, otherUserId];
    ids.sort();
    final String chatRoomId = ids.join('_');

    //Get messages from firebase
    return _firestore
        .collection('ChatRooms')
        .doc(chatRoomId)
        .collection('Messages')
        .orderBy(
          'timestamp',
          descending: false,
        ) //order by timestamp ( 1pm -> 2pm -> 3pm)
        .snapshots();
    //! descending: false, means the latest message is at the top
  }
}
