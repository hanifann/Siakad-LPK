part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
  
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterSucceed extends RegisterState {
  
}

class RegisterFailed extends RegisterState {
  final ErrorModel error;

  const RegisterFailed(this.error);
}

class RegisterLoading extends RegisterState {
  
}
