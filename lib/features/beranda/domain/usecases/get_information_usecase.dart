import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/beranda/domain/entities/information.dart';
import 'package:siakad_lpk/features/beranda/domain/repositories/information_repository.dart';

class GetInformationUseCase extends UseCase<Information, NoParams> {
  final InformationRepository repository;

  GetInformationUseCase({required this.repository});

  @override
  Future<Either<Failure, Information>?> call(NoParams params) async {
    return repository.getInformation();
  }
  
}