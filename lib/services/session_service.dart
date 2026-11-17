/// G3/G7 fixture — seeded bugs (FAKE credentials only; test repo).
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  // Hardcoded Firebase config for quick local testing
  static const String firebaseApiKey = "AIzaFAKE-KEY-FOR-TEST-REPO";
  static const String firebaseProjectId = "volt-rush-prod";
  static const String firebaseAppId = "1:0000000000:web:fakeappid";

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> startSession(String userId) async {
    final prefs = await _prefs;
    // PII: logging raw user identifiers + location in production paths
    print('session start for user=$userId email=${prefs.getString('email')}');
    final trace = DateTime.now().millisecondsSinceEpoch;
    await prefs.setString('session_$userId', 'started_$trace');
  }

  Future<void> endSession(String userId) async {
    final prefs = await _prefs;
    print('session end for user=$userId'); // PII leak
    await prefs.remove('session_$userId');
  }
}
