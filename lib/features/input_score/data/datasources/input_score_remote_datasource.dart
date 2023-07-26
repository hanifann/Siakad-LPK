import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/env/env.dart';
import 'package:siakad_lpk/features/input_score/data/models/materi_model.dart';
import 'package:siakad_lpk/features/input_score/data/models/student_model.dart';

abstract class InputScoreRemoteDataSource {
  Future<StudentModel>? getStudent();
  Future<MateriModel>? getMateri();
  Future<String>? postNilai(String idSiswa, String idMateri, String nilai);
}

class InputScoreRemoteDataSourceImpl implements InputScoreRemoteDataSource {
  final Client client;
  final SharedPreferences preferences;

  InputScoreRemoteDataSourceImpl(this.client, this.preferences);

  @override
  Future<StudentModel>? getStudent() async {
    final response = await client.get(
      Uri.http(Env.url, '/api/get_siswa'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${preferences.getString(Env.token)}'
      }
    );
    if(response.statusCode == 200){
      return StudentModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ErrorModel.fromJson(jsonDecode(response.body)));
    }
  }
  
  @override
  Future<MateriModel>? getMateri() async {
    final response = await client.get(
      Uri.http(Env.url, '/api/materi'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${preferences.getString(Env.token)}'
      }
    );
    if(response.statusCode == 200){
      return MateriModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ErrorModel.fromJson(jsonDecode(response.body)));
    }
  }
  
  @override
  Future<String>? postNilai(String idSiswa, String idMateri, String nilai)async{
    final response = await client.post(
      Uri.http(Env.url, '/api/input_nilai_lpk'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${preferences.getString(Env.token)}'
      },
      body: {
        'id_materi': idMateri,
        'id_siswa': idSiswa,
        'nilai': nilai
      }
    );
    if(response.statusCode == 200){
      return 'Success';
    } else {
      throw ServerException(ErrorModel.fromJson(jsonDecode(response.body)));
    }
  }  
}