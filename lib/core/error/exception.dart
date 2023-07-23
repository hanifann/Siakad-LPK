import 'package:siakad_lpk/core/error/model/error_model.dart';

class ServerException implements Exception {
  final ErrorModel error;

  ServerException(this.error);
}

class CacheException implements Exception {
  final String message;

  CacheException({
    this.message = 'Telah terjadi kesalahan, silahkan cek koneksi internet anda'
  });
}