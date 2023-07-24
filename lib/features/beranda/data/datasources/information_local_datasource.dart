import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/env/env.dart';
import 'package:siakad_lpk/features/beranda/data/models/information_model.dart';

abstract class InformationLocalDataSource {
  Future<void>? cachedInformation(InformationModel info);
  Future<InformationModel>? getCachedInformation();
}

class InformationLocalDataSourceImpl implements InformationLocalDataSource {
  final SharedPreferences preferences;

  InformationLocalDataSourceImpl({required this.preferences});

  @override
  Future<void>? cachedInformation(InformationModel info) {
    return preferences.setString(
      Env.info,
      jsonEncode(info.toJson())
    );
  }

  @override
  Future<InformationModel>? getCachedInformation() {
    final jsonString = preferences.getString(Env.info);
    if(jsonString != null){
      return Future.value(InformationModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
  
}