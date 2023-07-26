import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/input_score/domain/repositories/input_score_repository.dart';

class DeleteNilaiUseCase extends UseCase<String, DeleteNilaiParams> {
  final InputScoreRepository repository;

  DeleteNilaiUseCase(this.repository);

  @override
  Future<Either<Failure, String>?> call(params) async {
    return repository.deleteNilai(params.idNilai);
  }
  
}

class DeleteNilaiParams extends Equatable{
  final String idNilai;

  const DeleteNilaiParams(this.idNilai);

  @override
  List<Object?> get props => [
    idNilai
  ];
}