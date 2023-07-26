import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/env/env.dart';
import 'package:siakad_lpk/features/input_score/data/models/student_model.dart';

abstract class InputScoreLocalDataSource {
  Future<void>? cachedStudent(StudentModel student);
  Future<StudentModel>? getCachedStudent();
}

class InputScoreLocalDataSourceImpl implements InputScoreLocalDataSource {
  final SharedPreferences preferences;

  InputScoreLocalDataSourceImpl(this.preferences);

  @override
  Future<void>? cachedStudent(StudentModel student) {
    return preferences.setString(
      Env.student,
      jsonEncode(student.toJson())
    );
  }

  @override
  Future<StudentModel>? getCachedStudent() {
    final jsonString = preferences.getString(Env.student);
    if(jsonString != null){
      return Future.value(StudentModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
  
}