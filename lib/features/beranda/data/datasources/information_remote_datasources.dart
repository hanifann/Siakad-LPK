import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/env/env.dart';
import 'package:siakad_lpk/features/beranda/data/models/information_model.dart';

abstract class InformationRemoteDataSource {
  Future<InformationModel>? getInformation();
}

class InformationRemoteDataSourceImpl implements InformationRemoteDataSource {
  final Client client;
  final SharedPreferences preferences;

  InformationRemoteDataSourceImpl({required this.client, required this.preferences});

  @override
  Future<InformationModel>? getInformation() async {
    final response = await client.get(
      Uri.http(Env.url, '/api/information'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${preferences.getString(Env.token)}'
      }
    );
    if(response.statusCode == 200){
      return InformationModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ErrorModel.fromJson(jsonDecode(response.body)));
    }
  }
  
}