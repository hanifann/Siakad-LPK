import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/env/env.dart';
import 'package:siakad_lpk/features/input_score/data/models/materi_model.dart';
import 'package:siakad_lpk/features/input_score/data/models/student_model.dart';

abstract class InputScoreLocalDataSource {
  Future<void>? cachedStudent(StudentModel student);
  Future<StudentModel>? getCachedStudent();
  Future<void>? cachedMateri(MateriModel materi);
  Future<MateriModel>? getCachedMateri();
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
  
  @override
  Future<void>? cachedMateri(MateriModel materi) {
    return preferences.setString(
      Env.materi,
      jsonEncode(materi.toJson())
    );
  }
  
  @override
  Future<MateriModel>? getCachedMateri() {
    final jsonString = preferences.getString(Env.materi);
    if(jsonString != null){
      return Future.value(MateriModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
  
}