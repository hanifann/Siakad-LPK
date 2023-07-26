import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/input_score/domain/repositories/input_score_repository.dart';

class PostNilaiUseCase extends UseCase<String, NilaiParams> {
  final InputScoreRepository repository;

  PostNilaiUseCase(this.repository);

  @override
  Future<Either<Failure, String>?> call(params) async {
    return repository.postNilai(params.idSiswa, params.idMateri, params.nilai);
  }
  
}

class NilaiParams extends Equatable{
  final String idMateri;
  final String idSiswa;
  final String nilai;

  const NilaiParams({
    required this.idMateri, 
    required this.idSiswa, 
    required this.nilai
  });

  @override
  List<Object?> get props => [
    idMateri,
    idSiswa,
    nilai
  ];
}