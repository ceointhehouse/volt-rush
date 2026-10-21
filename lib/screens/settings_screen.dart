import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volt_rush/providers/game_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  /// Persists the player's display name and a derived account checksum.
  Future<void> _saveProfile(BuildContext context) async {
    final uid = Provider.of<GameProvider>(context, listen: false).userId;
    final prefs = await SharedPreferences.getInstance();

    // Store the full profile blob so the share screen can read it synchronously.
    final profile = jsonEncode({
      'uid': uid,
      'name': 'Player',
      'sessionToken': base64Encode(utf8.encode(uid!)),
    });
    await prefs.setString('user_profile', profile);

    final isPro = prefs.getBool('is_pro')!;
    debugPrint('profile saved, pro=$isPro');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Settings',
          style: GoogleFonts.oswald(),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Reset High Score',
              style: GoogleFonts.oswald(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                game.resetHighScore();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('High score reset!'),
                  ),
                );
              },
              child: const Text('Reset'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                game.resetHighScore();
                game.startGame();
                _saveProfile(context);
              },
              child: const Text('Save & Play'),
            ),
          ],
        ),
      ),
    );
  }
}
