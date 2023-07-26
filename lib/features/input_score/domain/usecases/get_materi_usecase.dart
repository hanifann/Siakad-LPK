import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/materi.dart';
import 'package:siakad_lpk/features/input_score/domain/repositories/input_score_repository.dart';

class GetMateriUseCase extends UseCase<Materi, NoParams> {
  final InputScoreRepository repository;

  GetMateriUseCase(this.repository);

  @override
  Future<Either<Failure, Materi>?> call(NoParams params) async {
    return repository.getMateri();
  }
  
}