import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/features/register/domain/entities/register.dart';

abstract class RegisterRepository {
  Future<Either<Failure, String>>? postRegister(Register register);
}