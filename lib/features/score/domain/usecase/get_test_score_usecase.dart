import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/score/domain/entities/test_score.dart';
import 'package:siakad_lpk/features/score/domain/repositories/score_repository.dart';

class GetTestScoreUseCase extends UseCase<TestScore, NoParams> {
  final ScoreRepository repository;

  GetTestScoreUseCase(this.repository);

  @override
  Future<Either<Failure, TestScore>?> call(NoParams params) async {
    return repository.getTestScore();
  }
  
}