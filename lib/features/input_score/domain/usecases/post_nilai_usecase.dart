import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';

class PostNilaiUseCase extends UseCase<String, NilaiParams> {
  @override
  Future<Either<Failure, String>?> call(params) {
    // TODO: implement call
    throw UnimplementedError();
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