import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/env/env.dart';
import 'package:siakad_lpk/features/score/data/models/lpk_score_model.dart';
import 'package:siakad_lpk/features/score/data/models/test_score_model.dart';

abstract class ScoreRemoteDataSource {
  Future<TestScoreModel>? getTestScore();
  Future<LpkScoreModel>? getLpkScore();
}

class ScoreRemoteDataSourceImpl implements ScoreRemoteDataSource {
  final Client client;
  final SharedPreferences preferences;

  ScoreRemoteDataSourceImpl(this.client, this.preferences);

  @override
  Future<LpkScoreModel>? getLpkScore() async {
    final response = await client.get(
      Uri.http(Env.url, '/api/nilai_lpk'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${preferences.getString(Env.token)}'
      }
    );
    if(response.statusCode == 200){
      return LpkScoreModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

  @override
  Future<TestScoreModel>? getTestScore() async {
   final response = await client.get(
      Uri.http(Env.url, '/api/nilai_ujian'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${preferences.getString(Env.token)}'
      }
    );
    if(response.statusCode == 200){
      return TestScoreModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ErrorModel.fromJson(jsonDecode(response.body)));
    }
  }
}