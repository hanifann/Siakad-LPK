import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/env/env.dart';
import 'package:siakad_lpk/features/score/data/models/lpk_score_model.dart';
import 'package:siakad_lpk/features/score/data/models/test_score_model.dart';

abstract class ScoreLocalDataSource {
  Future<void>? cachedTestScore(TestScoreModel test);
  Future<void>? cachedLpkScore(LpkScoreModel lpk);
  Future<TestScoreModel>? getCachedTestScore();
  Future<LpkScoreModel>? getCachedLpkScore();
}

class ScoreLocalDataSourceImpl implements ScoreLocalDataSource {
  final SharedPreferences preferences;

  ScoreLocalDataSourceImpl(this.preferences);

  @override
  Future<void>? cachedLpkScore(LpkScoreModel lpk) {
    return preferences.setString(
      Env.lpk,
      jsonEncode(lpk.toJson())
    );
  }

  @override
  Future<void>? cachedTestScore(TestScoreModel test) {
    return preferences.setString(
      Env.test,
      jsonEncode(test.toJson())
    );
  }

  @override
  Future<LpkScoreModel>? getCachedLpkScore() {
    final jsonString = preferences.getString(Env.lpk);
    if(jsonString != null){
      return Future.value(LpkScoreModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<TestScoreModel>? getCachedTestScore() {
    final jsonString = preferences.getString(Env.test);
    if(jsonString != null){
      return Future.value(TestScoreModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
  
}