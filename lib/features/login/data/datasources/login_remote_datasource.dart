import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/env/env.dart';
import 'package:siakad_lpk/features/login/data/models/login_model.dart';
import 'package:siakad_lpk/features/login/data/models/user_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginModel>? postLogin(String email, String password);
  Future<UserModel>? getUser();
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Client client;
  final SharedPreferences preferences;

  const LoginRemoteDataSourceImpl({
    required this.client, 
    required this.preferences
  });

  @override
  Future<UserModel> getUser() async {
    final response = await client.get(
      Uri.http(Env.url, '/api/me'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${preferences.getString(Env.token)}'
      },
    );
    if(response.statusCode == 200){
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

  @override
  Future<LoginModel> postLogin(String email, String password) async {
    final response = await client.post(
      Uri.http(Env.url, '/api/login'),
      headers: {
        'Accept': 'application/json'
      },
      body: {
        'email': email,
        'password': password
      }
    );
    if(response.statusCode == 200){
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ErrorModel.fromJson(jsonDecode(response.body)));
    }
  }
  
}