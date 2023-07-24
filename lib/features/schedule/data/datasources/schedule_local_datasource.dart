import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/env/env.dart';
import 'package:siakad_lpk/features/schedule/data/models/schedule_model.dart';

abstract class ScheduleLocalDataSource {
  Future<void>? cachedSchedule(ScheduleModel scheduleModel);
  Future<ScheduleModel>? getCachedSchedule();
}

class ScheduleLocalDataSourceImpl implements ScheduleLocalDataSource {
  final SharedPreferences preferences;

  ScheduleLocalDataSourceImpl(this.preferences);

  @override
  Future<void>? cachedSchedule(ScheduleModel scheduleModel) {
    return preferences.setString(
      Env.jadwal,
      jsonEncode(scheduleModel.toJson())
    );
  }

  @override
  Future<ScheduleModel>? getCachedSchedule() {
    final jsonString = preferences.getString(Env.jadwal);
    if(jsonString != null){
      return Future.value(ScheduleModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
  
}