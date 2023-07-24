import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/schedule/domain/entities/schedule.dart';
import 'package:siakad_lpk/features/schedule/domain/repositories/schedule_repository.dart';

class GetScheduleUseCase extends UseCase<Schedule, NoParams> {
  final ScheduleRepository repository;

  GetScheduleUseCase(this.repository);

  @override
  Future<Either<Failure, Schedule>?> call(NoParams params) async {
    return repository.getSchedule();
  }
  
}