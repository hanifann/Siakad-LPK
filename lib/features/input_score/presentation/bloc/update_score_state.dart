part of 'update_score_bloc.dart';

abstract class UpdateScoreState extends Equatable {
  const UpdateScoreState();
  
  @override
  List<Object> get props => [];
}

class UpdateScoreInitial extends UpdateScoreState {}

class UpdateScoreSucceed extends UpdateScoreState {
  
}

class UpdateScoreFailed extends UpdateScoreState {
  final ErrorModel error;

  const UpdateScoreFailed(this.error);
}

class UpdateScoreLoading extends UpdateScoreState {
  
}
