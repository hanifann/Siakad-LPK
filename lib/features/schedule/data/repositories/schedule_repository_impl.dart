import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/platform/network_info.dart';
import 'package:siakad_lpk/features/schedule/data/datasources/schedule_local_datasource.dart';
import 'package:siakad_lpk/features/schedule/data/datasources/schedule_remote_datasource.dart';
import 'package:siakad_lpk/features/schedule/domain/entities/schedule.dart';
import 'package:siakad_lpk/features/schedule/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final NetworkInfo networkInfo;
  final ScheduleRemoteDataSource remoteDataSource;
  final ScheduleLocalDataSource localDataSource;

  ScheduleRepositoryImpl(this.networkInfo, this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, Schedule>>? getSchedule() async {
    if(await networkInfo.isConnected){
      try {
        final response = await remoteDataSource.getSchedule();
        localDataSource.cachedSchedule(response!);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      } on FormatException catch (_) {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final jsonString = await localDataSource.getCachedSchedule();
        return Right(jsonString!);
      } on CacheException catch (_) {
        return const Left(CacheFailure());
      }
    }
  }
  
}