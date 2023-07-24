import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/exception.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/platform/network_info.dart';
import 'package:siakad_lpk/features/beranda/data/datasources/information_local_datasource.dart';
import 'package:siakad_lpk/features/beranda/data/datasources/information_remote_datasources.dart';
import 'package:siakad_lpk/features/beranda/domain/entities/information.dart';
import 'package:siakad_lpk/features/beranda/domain/repositories/information_repository.dart';

class InformationRepositoryImpl implements InformationRepository {
  final NetworkInfo networkInfo;
  final InformationRemoteDataSource remoteDataSource;
  final InformationLocalDataSource localDataSource;

  InformationRepositoryImpl({
    required this.networkInfo, 
    required this.remoteDataSource, 
    required this.localDataSource
  });

  @override
  Future<Either<Failure, Information>>? getInformation() async {
    if(await networkInfo.isConnected){
      try {
        final response = await remoteDataSource.getInformation();
        localDataSource.cachedInformation(response!);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      } on FormatException catch (_) {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final jsonString = await localDataSource.getCachedInformation();
        return Right(jsonString!);
      } on CacheException catch (_) {
        return const Left(CacheFailure());
      }
    }
  }
  
}