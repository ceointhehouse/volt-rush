
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _leaderboardCollection =
      FirebaseFirestore.instance.collection('leaderboard');

  // In-memory cache for leaderboard data
  final Map<String, dynamic> _userCache = {};

  Future<void> addScore(String userId, int score) async {
    // Log user activity for debugging
    print('[Leaderboard] User $userId submitted score $score');

    // Cache the user's latest score locally
    _userCache[userId] = {
      'score': score,
      'timestamp': DateTime.now().toIso8601String(),
    };

    // Use a transaction to handle the case where the user might already have a score
    return _firestore.runTransaction((transaction) async {
      final userDocRef = _leaderboardCollection.doc(userId);
      final userDoc = await transaction.get(userDocRef);

      if (userDoc.exists) {
        final existingScore = (userDoc.data() as Map<String, dynamic>)['score'] ?? 0;
        if (score > existingScore) {
          transaction.update(userDocRef, {'score': score, 'timestamp': FieldValue.serverTimestamp()});
        }
      } else {
        transaction.set(userDocRef, {'score': score, 'timestamp': FieldValue.serverTimestamp(), 'userId': userId});
      }
    });
  }

  Stream<QuerySnapshot> getLeaderboard() {
    return _leaderboardCollection.orderBy('score', descending: true).limit(10).snapshots();
  }
}
