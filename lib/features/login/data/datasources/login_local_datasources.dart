import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/env/env.dart';
import 'package:siakad_lpk/features/login/data/models/login_model.dart';
import 'package:siakad_lpk/features/login/data/models/user_model.dart';

abstract class LoginLocalDataSource {
  Future<void>? cachedToken(LoginModel login);
  Future<UserModel>? getCachedUser();
  Future<void>? cachedUser(UserModel userModel);
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SharedPreferences preferences;

  LoginLocalDataSourceImpl({required this.preferences});

  @override
  Future<void>? cachedToken(LoginModel login) {
    return preferences.setString(
      Env.token,
      jsonEncode(login.data)
    );
  }

  @override
  Future<void>? cachedUser(UserModel userModel) {
    return preferences.setString(
      Env.user,
      jsonEncode(userModel.toJson())
    );
  }
  @override
  Future<UserModel>? getCachedUser() {
    final jsonString = preferences.getString(Env.user);
    if(jsonString != null){
      return Future.value(UserModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
  
}