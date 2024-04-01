import 'dart:async';

import 'persistence/local_storage_player_progress_persistence.dart';
import 'package:flutter/foundation.dart';

import 'persistence/player_progress_persistence.dart';

/// Encapsulates the player's progress.
class PlayerProgress extends ChangeNotifier {
  PlayerProgress({PlayerProgressPersistence? store})
      : _store = store ?? LocalStoragePlayerProgressPersistence() {
    getLatestFromStore();
  }

  /// TODO: If needed, replace this with some other mechanism for saving
  ///       the player's progress. Currently, this uses the local storage
  ///       (i.e. NSUserDefaults on iOS, SharedPreferences on Android
  ///       or local storage on the web).
  final PlayerProgressPersistence _store;
  int firstPlay = 0;
  List<int> ff = [];
  List<int> _levelsFinished = [];
  List<int> _nextLevel = [];

  /// The times for the levels that the player has finished so far.
  List<int> get levels => _levelsFinished;
  List<int> get nextlevels => _nextLevel;

  /// Fetches the latest data from the backing persistence store.
  Future<void> getLatestFromStore() async {
    final levelsFinished = await _store.getFinishedLevels();
    if (!listEquals(_levelsFinished, levelsFinished)) {
      _levelsFinished = _levelsFinished;
      notifyListeners();
    }
  }

  /// Resets the player's progress so it's like if they just started
  /// playing the game for the first time.
  void reset() {
    _store.reset();
    _levelsFinished.clear();
    notifyListeners();
  }

  /// Registers [level] as reached.
  ///
  /// If this is higher than [highestLevelReached], it will update that
  /// value and save it to the injected persistence store.
  void setLevelFinished(int level, int time) {
    print('////////////////////////////////');
    print(time);
    print('this is levels finished: ${_levelsFinished.length}');
    print('This is the current level: ${level}');
    if (time > 100 && level == 1 && _nextLevel.length <= 0) {
      _nextLevel.add(time);
      notifyListeners();
      unawaited(_store.saveLevelFinished(level, time));
    }

    if (time > 200 && level == 2) {
      _nextLevel.add(time);
      notifyListeners();
      unawaited(_store.saveLevelFinished(level, time));
    }

    if (level == 3) {
      _nextLevel.add(time);
      notifyListeners();
      unawaited(_store.saveLevelFinished(level, time));
    }

    if (level == 1) {
      if (_levelsFinished.isNotEmpty) {
        if (_levelsFinished[0] < time) {
          _levelsFinished.removeAt(0);
          _levelsFinished.insert(0, time);
        }
        //_levelsFinished[0] = time;
        notifyListeners();
        unawaited(_store.saveLevelFinished(level, time));
      } else {
        _levelsFinished.add(time);
        notifyListeners();
        unawaited(_store.saveLevelFinished(level, time));
      }
    }

    if (level == 2) {
      if (_levelsFinished.length > 1) {
        if (_levelsFinished[1] < time) {
          _levelsFinished.removeAt(1);
          _levelsFinished.insert(1, time);
        }
        //_levelsFinished[0] = time;
        notifyListeners();
        unawaited(_store.saveLevelFinished(level, time));
      } else {
        _levelsFinished.add(time);
        notifyListeners();
        unawaited(_store.saveLevelFinished(level, time));
      }
    }

    if (level == 3) {
      if (_levelsFinished.length > 2) {
        if (_levelsFinished[1] < time) {
          _levelsFinished.removeAt(2);
          _levelsFinished.insert(2, time);
        }
        //_levelsFinished[0] = time;
        notifyListeners();
        unawaited(_store.saveLevelFinished(level, time));
      } else {
        _levelsFinished.add(time);
        notifyListeners();
        unawaited(_store.saveLevelFinished(level, time));
      }
    }

    if (level < _levelsFinished.length - 1) {
      print('level< _levelsFinished.length');
      final currentTime = _levelsFinished[level - 1];
      if (time < currentTime) {
        _levelsFinished[level - 1] = time;
        notifyListeners();
        unawaited(_store.saveLevelFinished(level, time));
      }
    } else {
      // print('else');
      // _levelsFinished.add(time);
      // notifyListeners();
      // unawaited(_store.saveLevelFinished(level, time));
    }
    print(_levelsFinished);
    print(_nextLevel);
  }
}
