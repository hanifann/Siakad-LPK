import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/student.dart';
import 'package:siakad_lpk/features/input_score/domain/repositories/input_score_repository.dart';

class GetStudentUseCase extends UseCase<Student, NoParams> {
  final InputScoreRepository repository;

  GetStudentUseCase(this.repository);

  @override
  Future<Either<Failure, Student>?> call(NoParams params) async {
    return repository.getStudent();
  }
  
}