import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Service for managing channels.
/// Single storage only: channels/{channelId} and channels/{channelId}/messages.
/// Do not use UserChannels — all channel data is in the channels collection.
class ChannelService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Fetch channels where current user is a member.
  Stream<List<QueryDocumentSnapshot>> fetchChannels() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('No authenticated user found');
    }

    // Stream of snapshots
    return _firestore
        .collection('channels')
        .where('members', arrayContains: userId)
        .snapshots()
        .map((snapshot) {
          // Sort manually by lastTimestamp fallback createdAt
          final docs = snapshot.docs.toList();
          docs.sort((a, b) {
            final tsA = a.data()['lastTimestamp'] as Timestamp?;
            final tsB = b.data()['lastTimestamp'] as Timestamp?;

            // fallback to createdAt if lastTimestamp is null
            final createdA = a.data()['createdAt'] as Timestamp?;
            final createdB = b.data()['createdAt'] as Timestamp?;

            final tA = tsA ?? createdA ?? Timestamp(0, 0);
            final tB = tsB ?? createdB ?? Timestamp(0, 0);

            return tB.compareTo(tA); // descending
          });

          return docs;
        });
  }

  /// Create a new channel. One doc in channels collection.
  Future<void> createChannel(
    String channelName,
    List<String> userIds,
    String channelDescription,
  ) async {
    final curUser = _auth.currentUser;
    if (curUser == null) {
      throw Exception('No authenticated user found');
    }

    final allMembers = [curUser.uid, ...userIds].toList();
    final channelRef = _firestore.collection('channels').doc();

    final unreadCounts = <String, int>{};
    for (final uid in allMembers) {
      unreadCounts[uid] = 0;
    }

    await channelRef.set({
      'channelName': channelName,
      'members': allMembers,
      'channelDescription': channelDescription,
      'createdAt': FieldValue.serverTimestamp(),
      'lastTimestamp': FieldValue.serverTimestamp(),
      'unreadCounts': unreadCounts,
    });
  }

  /// Stream of channel messages.
  Stream<QuerySnapshot> getChannelMessagesStream(String channelId) {
    return _firestore
        .collection('channels')
        .doc(channelId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  /// Resolve sender display name from Firestore users collection (nickname).
  Future<String> _resolveSenderName(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    final name = doc.data()?['name'] as String?;
    if (name != null && name.trim().isNotEmpty) return name.trim();

    final authUser = _auth.currentUser;
    if (authUser != null) {
      final dn = authUser.displayName;
      if (dn != null && dn.trim().isNotEmpty) return dn.trim();
      final em = authUser.email;
      if (em != null && em.isNotEmpty) return em;
    }

    return 'Unknown';
  }

  /// Mark channel as read for current user (unreadCounts[uid] = 0).
  Future<void> markChannelAsRead(String channelId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final channelRef = _firestore.collection('channels').doc(channelId);
    await channelRef.set({
      'unreadCounts.$userId': 0,
    }, SetOptions(merge: true));
  }

  /// Send message: add to channel messages, update last message and unreadCounts.
  Future<void> sendMessageToChannel(
    String channelId,
    String message, {
    required List<String> memberIds,
  }) async {
    final curUser = _auth.currentUser;
    if (curUser == null) {
      throw Exception('No authenticated user found!');
    }

    final senderName = await _resolveSenderName(curUser.uid);
    final senderEmail = curUser.email ?? '';
    final timestamp = FieldValue.serverTimestamp();

    final channelRef = _firestore.collection('channels').doc(channelId);
    final messageRef = channelRef.collection('messages').doc();

    final updateData = <String, dynamic>{
      'lastMessage': message,
      'lastMessageTimestamp': timestamp,
      'lastMessageSender': curUser.uid,
      'lastMessageSenderName': senderName,
      'lastMessageSenderEmail': senderEmail,
      'lastTimestamp': timestamp,
      'unreadCounts.${curUser.uid}': 0,
    };

    for (final uid in memberIds) {
      if (uid != curUser.uid) {
        updateData['unreadCounts.$uid'] = FieldValue.increment(1);
      }
    }

    final batch = _firestore.batch();
    batch.set(messageRef, {
      'text': message,
      'senderId': curUser.uid,
      'senderName': senderName,
      'senderEmail': senderEmail,
      'timestamp': timestamp,
    });
    batch.set(channelRef, updateData, SetOptions(merge: true));
    await batch.commit();
  }

  /// Add a new member to a channel.
  Future<void> addNewMemnerToChannel(
    String channelId,
    String newMemberId,
  ) async {
    final curUser = _auth.currentUser;
    if (curUser == null) {
      throw Exception('No authenticated user found');
    }

    final channelRef = _firestore.collection('channels').doc(channelId);
    await channelRef.set({
      'members': FieldValue.arrayUnion([newMemberId]),
      'unreadCounts.$newMemberId': 0,
      'lastTimestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  /// Delete channel.
  Future<void> deleteChannel(String channelId) async {
    final curUser = _auth.currentUser;
    if (curUser == null) {
      throw Exception('No authenticated user found!');
    }

    await _firestore.collection('channels').doc(channelId).delete();
  }
}
