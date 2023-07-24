import 'dart:convert';

import 'package:http/http.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/env/env.dart';
import 'package:siakad_lpk/features/register/data/models/register_model.dart';

abstract class RegisterRemoteDataSource {
  Future<String> postRegister(RegisterModel register);
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final Client client;

  RegisterRemoteDataSourceImpl({required this.client});

  @override
  Future<String> postRegister(RegisterModel register) async {
    final response = await client.post(
      Uri.http(Env.url, '/api/pendaftaran'),
      headers: {
        'Accept': 'application/json'
      },
      body: register.toJson()
    );
    if(response.statusCode == 200){
      return 'Success';
    } else {
      throw ServerException(ErrorModel.fromJson(jsonDecode(response.body)));
    }
  }
  
}