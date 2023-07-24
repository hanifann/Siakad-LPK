import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/platform/network_info.dart';
import 'package:siakad_lpk/features/login/data/datasources/login_local_datasources.dart';
import 'package:siakad_lpk/features/login/data/datasources/login_remote_datasource.dart';
import 'package:siakad_lpk/features/login/domain/entities/login.dart';
import 'package:siakad_lpk/features/login/domain/entities/user.dart';
import 'package:siakad_lpk/features/login/domain/repositories/login_repositort.dart';

class LoginRepositoryImpl implements LoginRepository {
  final NetworkInfo networkInfo;
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;

  LoginRepositoryImpl({
    required this.networkInfo, 
    required this.remoteDataSource, 
    required this.localDataSource
  });

  @override
  Future<Either<Failure, User>>? getUser() async {
    if(await networkInfo.isConnected){
      try {
        final response = await remoteDataSource.getUser();
        localDataSource.cachedUser(response!);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      } on FormatException catch (_){
        return const Left(ServerFailure());
      }
    } else {
      try{
        final response = await localDataSource.getCachedUser();
        return Right(response!);
      } on CacheException catch (_){
        return const Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Login>>? postLogin({required String email, required String password}) async {
    if(await networkInfo.isConnected){
      try {
        final response = await remoteDataSource.postLogin(email, password);
        localDataSource.cachedToken(response!);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      } on FormatException catch (_){
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
  
}