import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/platform/network_info.dart';
import 'package:siakad_lpk/features/register/data/datasources/register_remote_datasources.dart';
import 'package:siakad_lpk/features/register/data/models/register_model.dart';
import 'package:siakad_lpk/features/register/domain/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final NetworkInfo networkInfo;
  final RegisterRemoteDataSource remoteDataSource;

  const RegisterRepositoryImpl({
    required this.networkInfo, 
    required this.remoteDataSource
  });

  @override
  Future<Either<Failure, String>>? postRegister(RegisterModel register) async {
    if(await networkInfo.isConnected){
      try {
        await remoteDataSource.postRegister(register);
        return const Right('Success');
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      }
    } else {
      return const Left(CacheFailure());
    }
  }
  
}