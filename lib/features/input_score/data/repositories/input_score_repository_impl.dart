import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/platform/network_info.dart';
import 'package:siakad_lpk/features/input_score/data/datasources/input_score_local_datasource.dart';
import 'package:siakad_lpk/features/input_score/data/datasources/input_score_remote_datasource.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/materi.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/student.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/student_score.dart';
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

  @override
  Future<Either<Failure, Materi>>? getMateri() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getMateri();
        localDataSource.cachedMateri(response!);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      }
    } else {
      try {
        final jsonString = await localDataSource.getCachedMateri();
        return Right(jsonString!);
      } on CacheException catch (_) {
        return const Left(CacheFailure());
      }
    }
  }
  
  @override
  Future<Either<Failure, String>>? postNilai(String idSiswa, String idMateri, String nilai)async{
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.postNilai(idSiswa, idMateri, nilai);
        return Right(response!);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      }
    } else {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>>? deleteNilai(String idNilai) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.deleteNilai(idNilai);
        return Right(response!);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      }
    } else {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>>? editNilai(String idNilai, String idSiswa, String idMateri, String nilai) async  {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.editNilai(idNilai, idSiswa, idMateri, nilai);
        return Right(response!);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      }
    } else {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, StudentScore>>? getNilai(String idMateri) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getNilai(idMateri);
        return Right(response!);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      }
    } else {
      return const Left(CacheFailure());
    }
  }
}