import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/features/beranda/domain/entities/information.dart';

abstract class InformationRepository {
  Future<Either<Failure, Information>>? getInformation();
}