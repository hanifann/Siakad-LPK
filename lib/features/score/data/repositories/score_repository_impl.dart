import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/platform/network_info.dart';
import 'package:siakad_lpk/features/score/data/datasources/score_local_datasources.dart';
import 'package:siakad_lpk/features/score/data/datasources/score_remote_datasources.dart';
import 'package:siakad_lpk/features/score/domain/entities/lpk_score.dart';
import 'package:siakad_lpk/features/score/domain/entities/test_score.dart';
import 'package:siakad_lpk/features/score/domain/repositories/score_repository.dart';

class ScoreRepositoryImpl implements ScoreRepository {
  final NetworkInfo networkInfo;
  final ScoreRemoteDataSource remoteDataSource;
  final ScoreLocalDataSource localDataSource;

  ScoreRepositoryImpl(this.networkInfo, this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, LpkScore>>? getLpkScore() async {
    if(await networkInfo.isConnected){
      try {
        final response = await remoteDataSource.getLpkScore();
        localDataSource.cachedLpkScore(response!);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      }
    } else {
      try {
        final jsonString = await localDataSource.getCachedLpkScore();
        return Right(jsonString!);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, TestScore>>? getTestScore() async {
    if(await networkInfo.isConnected){
      try {
        final response = await remoteDataSource.getTestScore();
        localDataSource.cachedTestScore(response!);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      }
    } else {
      try {
        final jsonString = await localDataSource.getCachedTestScore();
        return Right(jsonString!);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }
  
}