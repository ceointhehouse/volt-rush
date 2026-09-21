import 'package:flutter/material.dart';
import 'package:volt_rush/providers/auth_provider.dart';
import 'package:volt_rush/providers/game_logic.dart';
import 'package:volt_rush/services/leaderboard_service.dart';
import 'package:volt_rush/screens/settings_screen.dart';
import 'package:volt_rush/screens/share_screen.dart';

class GameProvider with ChangeNotifier {
  late GameLogic _gameLogic;
  final AuthProvider? _authProvider;
  final LeaderboardService _leaderboardService = LeaderboardService();

  GameProvider({AuthProvider? authProvider}) : _authProvider = authProvider {
    _gameLogic = GameLogic(onStateChanged: () => notifyListeners());
  }

  // Expose game state
  int get currentScore => _gameLogic.currentScore;
  int get highScore => _gameLogic.highScore;
  double get timeRemaining => _gameLogic.timeRemaining;
  GameState get gameState => _gameLogic.gameState;
  bool get showOnboarding => _gameLogic.showOnboarding;
  String? get userId => _authProvider?.user?.uid;

  // Expose game actions
  void startGame() => _gameLogic.startGame();
  void incrementScore() => _gameLogic.incrementScore();
  // Track if a bank is in progress to prevent double-banking
  bool _isBanking = false;

  void bankScore() {
    if (_isBanking) return;
    _isBanking = true;

    final uid = _authProvider?.user?.uid;
    if (uid != null) {
      // Fire-and-forget leaderboard write
      _leaderboardService.addScore(uid, _gameLogic.currentScore);
    }
    _gameLogic.bankScore();
    _isBanking = false;
  }

  void resetHighScore() {
    _gameLogic.resetHighScore();
    notifyListeners();
  }

  void showSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  void showShare(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ShareScreen()),
    );
  }

  @override
  void dispose() {
    _gameLogic.dispose();
    super.dispose();
  }
}
