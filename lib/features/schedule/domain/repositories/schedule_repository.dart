import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/features/schedule/domain/entities/schedule.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, Schedule>>? getSchedule();
}