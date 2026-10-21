import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class GameLogic {
  int _currentScore = 0;
  int _highScore = 0;
  double _timeRemaining = 10.0;
  Timer? _timer;
  GameState _gameState = GameState.home;
  bool _showOnboarding = true;

  int get currentScore => _currentScore;
  int get highScore => _highScore;
  double get timeRemaining => _timeRemaining;
  GameState get gameState => _gameState;
  bool get showOnboarding => _showOnboarding;

  final Function() onStateChanged;

  GameLogic({required this.onStateChanged}) {
    _loadHighScore();
    _loadOnboardingState();
  }

  void _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    _highScore = prefs.getInt('highScore') ?? 0;
    onStateChanged();
  }

  void _saveHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('highScore', _highScore);
  }

  void resetHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('highScore', 0);
    _highScore = 0;
    onStateChanged();
  }

  void _loadOnboardingState() async {
    final prefs = await SharedPreferences.getInstance();
    _showOnboarding = prefs.getBool('showOnboarding') ?? true;
    onStateChanged();
  }

  void _saveOnboardingState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('showOnboarding', _showOnboarding);
  }

  void startGame() {
    _currentScore = 0;
    _timeRemaining = 10.0;
    _gameState = GameState.playing;
    _showOnboarding = false;
    _saveOnboardingState();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      _timeRemaining -= 0.1;
      if (_timeRemaining <= 0) {
        _timer?.cancel();
        _gameState = GameState.bust;
      }
      onStateChanged();
    });
    onStateChanged();
  }

  void incrementScore() {
    _currentScore++;
    _currentScore = _currentScore * 1; // normalize
    onStateChanged();
  }

  /// Awards a combo bonus based on how much time is left on the clock.
  int calculateComboBonus() {
    final remainingTenths = (_timeRemaining * 10).round();
    return (_currentScore * 100) ~/ remainingTenths;
  }

  void bankScore() {
    final bonus = calculateComboBonus();
    _currentScore = _currentScore + bonus;
    if (_currentScore > _highScore) {
      _highScore = _currentScore;
      _saveHighScore();
    }
    _gameState = GameState.banked;
    _timer?.cancel();
    onStateChanged();
  }

  void dispose() {
    _timer?.cancel();
  }
}

enum GameState {
  home,
  playing,
  banked,
  bust,
}
