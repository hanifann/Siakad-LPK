import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/features/login/domain/entities/login.dart';
import 'package:siakad_lpk/features/login/domain/entities/user.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login>>? postLogin({
    required String email, 
    required String password
  });
  Future<Either<Failure, User>>? getUser();
  Future<Either<Failure, User>>? getLocalUser();
}