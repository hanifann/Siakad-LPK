part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class PostRegisterEvent extends RegisterEvent {
  final RegisterModel register;

  const PostRegisterEvent(this.register);
}
