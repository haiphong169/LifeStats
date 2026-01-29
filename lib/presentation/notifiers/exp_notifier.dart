import 'package:flutter/widgets.dart';

class ExpNotifier with ChangeNotifier {
  int _level = 1;
  int _currentXp = 0;
  int _xpForNextLevel = 10;

  double get progress => _currentXp / _xpForNextLevel;

  int get level => _level;
  int get currentXp => _currentXp;
  int get xpForNextLevel => _xpForNextLevel;

  void gainXp(int amount) {
    _currentXp += amount;

    if (_currentXp >= _xpForNextLevel) {
      _currentXp -= _xpForNextLevel;
      _level++;
      _xpForNextLevel = _getNewXpForNextLevel(_level);
    }

    notifyListeners();
  }

  int _getNewXpForNextLevel(int level) {
    return level * 10;
  }
}
