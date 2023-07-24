import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/env/env.dart';
import 'package:siakad_lpk/features/schedule/data/models/schedule_model.dart';

abstract class ScheduleRemoteDataSource {
  Future<ScheduleModel>? getSchedule();
}

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final Client client;
  final SharedPreferences preferences;

  const ScheduleRemoteDataSourceImpl(this.client, this.preferences);

  @override
  Future<ScheduleModel>? getSchedule() async {
    final response = await client.get(
      Uri.http(Env.url, '/api/jadwal'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${preferences.getString(Env.token)}'
      }
    );
    if(response.statusCode == 200){
      return ScheduleModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ErrorModel.fromJson(jsonDecode(response.body)));
    }
  }
  
}