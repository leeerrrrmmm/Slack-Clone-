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
    if (currentUser == null) throw Exception('No authenticated user found');

    final curUserId = currentUser.uid;
    final curUserEmail = currentUser.email ?? 'unknown@gmail.com';
    final curUserName = currentUser.displayName ?? 'unknown';
    final timestamp = Timestamp.now();

    final ids = [curUserId, receiverId]..sort();
    final chatRoomId = ids.join('_');

    final messageModel = MessageModel(
      senderId: curUserId,
      sendername: curUserName,
      senderEmail: curUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp.toDate(),
    );

    // Save message to chat room
    await _firestore
        .collection('ChatRooms')
        .doc(chatRoomId)
        .collection('Messages')
        .add(messageModel.toMap());

    // Update user chat for both users (receiver gets unread count +1)
    await _updateUserChat(
      userId: curUserId,
      otherUserId: receiverId,
      chatRoomId: chatRoomId,
      lastMessage: message,
      timestamp: timestamp,
      incrementUnread: false,
    );

    await _updateUserChat(
      userId: receiverId,
      otherUserId: curUserId,
      chatRoomId: chatRoomId,
      lastMessage: message,
      timestamp: timestamp,
      incrementUnread: true,
    );
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

  ///Get list of chat room for cur user
  Stream<QuerySnapshot> getUserChats() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('No authenticated user found');
    }

    return _firestore
        .collection('UserChats')
        .doc(userId)
        .collection('chats')
        .orderBy('lastTimestamp', descending: true)
        .snapshots();
  }

  /// Get list of chats where current user has unread messages
  Stream<QuerySnapshot> getUnreadUserChats() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('No authenticated user found');
    }

    return _firestore
        .collection('UserChats')
        .doc(userId)
        .collection('chats')
        .where('unreadCount', isGreaterThan: 0)
        .orderBy('unreadCount', descending: true)
        .snapshots();
  }

  /// Mark chat as read (set unread count to 0) and record read time for read receipts
  Future<void> markChatAsRead(String chatRoomId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final batch = _firestore.batch();
    final userChatRef = _firestore
        .collection('UserChats')
        .doc(userId)
        .collection('chats')
        .doc(chatRoomId);
    batch.set(userChatRef, {'unreadCount': 0}, SetOptions(merge: true));

    final chatRoomRef = _firestore.collection('ChatRooms').doc(chatRoomId);
    batch.set(
      chatRoomRef,
      {'lastRead_$userId': FieldValue.serverTimestamp()},
      SetOptions(merge: true),
    );
    await batch.commit();
  }

  /// Stream of chat room doc for read receipts (lastRead_{receiverId}).
  Stream<DocumentSnapshot<Object?>> getChatRoomReadReceipts(String chatRoomId) {
    return _firestore.collection('ChatRooms').doc(chatRoomId).snapshots();
  }

  /// Update user chat
  Future<void> _updateUserChat({
    required String userId,
    required String otherUserId,
    required String chatRoomId,
    required String lastMessage,
    required Timestamp timestamp,
    bool incrementUnread = false,
  }) async {
    final data = <String, dynamic>{
      'otherUserId': otherUserId,
      'lastMessage': lastMessage,
      'lastTimestamp': timestamp,
    };
    if (incrementUnread) {
      data['unreadCount'] = FieldValue.increment(1);
    }
    await _firestore
        .collection('UserChats')
        .doc(userId)
        .collection('chats')
        .doc(chatRoomId)
        .set(data, SetOptions(merge: true));
  }
}
