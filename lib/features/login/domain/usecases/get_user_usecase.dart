import 'package:dartz/dartz.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/login/domain/entities/user.dart';
import 'package:siakad_lpk/features/login/domain/repositories/login_repositort.dart';

class GetUserUseCase extends UseCase<User, NoParams> {
  final LoginRepository repository;

  GetUserUseCase({required this.repository});

  @override
  Future<Either<Failure, User>?> call(NoParams params) async {
    return repository.getUser();
  }
  
}