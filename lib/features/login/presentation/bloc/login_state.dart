part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSucceed extends LoginState {
  final Login login;

  const LoginSucceed(this.login);
}

class LoginFailed extends LoginState {
  final ErrorModel error;

  const LoginFailed(this.error);
}

 class LoginLoading extends LoginState {
   
 }
