import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/features/register/data/models/register_model.dart';

abstract class RegisterRepository {
  Future<Either<Failure, String>>? postRegister(RegisterModel register);
}