import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/score/domain/entities/lpk_score.dart';
import 'package:siakad_lpk/features/score/domain/repositories/score_repository.dart';

class GetLpkScoreUseCase extends UseCase<LpkScore, NoParams> {
  final ScoreRepository repository;

  GetLpkScoreUseCase(this.repository);

  @override
  Future<Either<Failure, LpkScore>?> call(NoParams params) async {
    return repository.getLpkScore();
  }
  
}