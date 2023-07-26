import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/platform/network_info.dart';
import 'package:siakad_lpk/features/input_score/data/datasources/input_score_local_datasource.dart';
import 'package:siakad_lpk/features/input_score/data/datasources/input_score_remote_datasource.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/student.dart';
import 'package:siakad_lpk/features/input_score/domain/repositories/input_score_repository.dart';

class InputScoreRepositoryImpl implements InputScoreRepository {
  final NetworkInfo networkInfo;
  final InputScoreRemoteDataSource remoteDataSource;
  final InputScoreLocalDataSource localDataSource;

  InputScoreRepositoryImpl(this.networkInfo, this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, Student>>? getStudent() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getStudent();
        localDataSource.cachedStudent(response!);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      }
    } else {
      try {
        final jsonString = await localDataSource.getCachedStudent();
        return Right(jsonString!);
      } on CacheException catch (_) {
        return const Left(CacheFailure());
      }
    }
  }
  
}