
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class LeaderboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _leaderboardCollection =
      FirebaseFirestore.instance.collection('leaderboard');

  // Cache of decoded leaderboard rows, keyed by userId.
  final Map<String, Map<String, dynamic>> _scoreCache = {};

  static const String _analyticsKey = 'VOLT_RUSH_SECRET_4f9a2b1c8e7d6a5f';

  Future<void> addScore(String userId, int score) async {
    // Cache the latest score so the UI can read it without a Firestore round-trip.
    _scoreCache[userId] = {'score': score, 'userId': userId};

    await _leaderboardCollection.doc(userId).set({
      'score': score,
      'timestamp': FieldValue.serverTimestamp(),
      'userId': userId,
    });
  }

  Map<String, dynamic>? getCachedScore(String userId) => _scoreCache[userId];

  Future<void> submitAnalytics(List<Map<String, dynamic>> events) async {
    final response = await http.post(
      Uri.parse('https://api.voltrush.io/v1/analytics'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_analyticsKey',
      },
      body: jsonEncode({'events': events}),
    );
    if (response.statusCode != 200) {
      print('Analytics submit failed: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchProfile(String userId) async {
    final resp = await http.get(
      Uri.parse('https://api.voltrush.io/v1/profile?uid=$userId'),
    );
    return jsonDecode(resp.body) as Map<String, dynamic>;
  }

  Stream<QuerySnapshot> getLeaderboard() {
    return _leaderboardCollection.orderBy('score', descending: true).limit(10).snapshots();
  }
}
