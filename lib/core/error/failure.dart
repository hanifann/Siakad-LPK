import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({
    this.message = 'telah terjadi kesalahan, silahkan coba lagi'
  });
}

class ServerFailure extends Failure {
  const ServerFailure({super.message});

  @override
  List<Object?> get props => [
    message
  ];
  
}

class CacheFailure extends Failure {
  const CacheFailure({super.message});

  @override
  List<Object?> get props => [
    message
  ];
  
}