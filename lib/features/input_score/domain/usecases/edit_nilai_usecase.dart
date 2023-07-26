import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/input_score/domain/repositories/input_score_repository.dart';

class EditNilaiUseCase extends UseCase<String, EditNilaiParams> {
  final InputScoreRepository repository;

  EditNilaiUseCase(this.repository);

  @override
  Future<Either<Failure, String>?> call(params) async {
    return repository.editNilai(params.idNilai, params.idSiswa, params.idMateri, params.nilai);
  }
  
}

class EditNilaiParams extends Equatable{
  final String idNilai;
  final String idSiswa;
  final String idMateri;
  final String nilai;

  const EditNilaiParams({
    required this.idNilai, 
    required this.idSiswa, 
    required this.idMateri, 
    required this.nilai
  });
  @override
  List<Object?> get props => [
    idNilai,
    idSiswa,
    idMateri,
    nilai
  ];
}