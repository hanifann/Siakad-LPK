import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/failure.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/login/domain/entities/login.dart';
import 'package:siakad_lpk/features/login/domain/entities/user.dart';
import 'package:siakad_lpk/features/login/domain/repositories/login_repositort.dart';

class PostLoginUseCase extends UseCase<Login, UserParams> {
  final LoginRepository repository;

  PostLoginUseCase({required this.repository});

  @override
  Future<Either<Failure, Login>?> call(params) async {
    return repository.postLogin(email: params.email, password: params.password);
  }
  
}

class UserParams extends Equatable{
  final String email;
  final String password;

  const UserParams(this.email, this.password);
  @override
  List<Object?> get props => [
    email,
    password
  ];
}