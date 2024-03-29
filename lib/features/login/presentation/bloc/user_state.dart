part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final User user;

  const UserLoaded(this.user);
}

class UserFailed extends UserState {
  final ErrorModel error;

  const UserFailed(this.error);
}

class UserLoading extends UserState {
  
}
