import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/student_score.dart';
import 'package:siakad_lpk/features/input_score/domain/repositories/input_score_repository.dart';

class GetNilaiUseCase extends UseCase<StudentScore, GetNilaiParams> {
  final InputScoreRepository repository;

  GetNilaiUseCase(this.repository);

  @override
  Future<Either<Failure, StudentScore>?> call(GetNilaiParams params) async {
    return repository.getNilai(params.idMateri);
  }
  
}

class GetNilaiParams extends Equatable{
  final String idMateri;

  const GetNilaiParams(this.idMateri);
  

  @override
  List<Object?> get props => [
    idMateri
  ];
}