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
    final request = MultipartRequest('POST', Uri.http(Env.url, '/api/pendaftaran'));
    request.fields['full_name'] = register.fullName;
    request.fields['email'] = register.email;
    request.fields['password'] = register.password;
    request.fields['ktp'] = register.ktp;
    request.fields['kontak'] = register.kontak;
    request.fields['kelas'] = register.kelas;
    request.fields['alamat'] = register.alamat;
    request.fields['tempat_lahir'] = register.tempatLahir;
    request.fields['tgl_lahir'] = register.tglLahir;
    request.fields['pendidikan_terakhir'] = register.pendidikanTerakhir;
    request.fields['status'] = register.status;
    request.fields['agama'] = register.agama;
    request.fields['nama_ortu'] = register.namaOrtu;
    request.fields['pengalaman_kerja'] = register.pengalaman;
    request.fields['metode_bayar'] = register.metodeBayar;
    
    final profilePic = await MultipartFile.fromPath('image', register.image);
    final proof = await MultipartFile.fromPath('bukti_bayar', register.image);

    request.files.add(profilePic);
    request.files.add(proof);

    request.headers['Accept'] = 'application/json';

    final response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    if(response.statusCode == 200){
      return 'Success';
    } else {
      throw ServerException(ErrorModel.fromJson(jsonDecode(responseString)));
    }
  }
  
}