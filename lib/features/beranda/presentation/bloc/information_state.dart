part of 'information_bloc.dart';

abstract class InformationState extends Equatable {
  const InformationState();
  
  @override
  List<Object> get props => [];
}

class InformationInitial extends InformationState {}

class InformationLoaded extends InformationState {
  final Information information;

  const InformationLoaded(this.information);
}

class InformationFailed extends InformationState {
  final ErrorModel error;

  const InformationFailed(this.error);
}

class InformnationLoading extends InformationState {
  
}
