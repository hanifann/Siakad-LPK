part of 'delete_score_bloc.dart';

abstract class DeleteScoreState extends Equatable {
  const DeleteScoreState();
  
  @override
  List<Object> get props => [];
}

class DeleteScoreInitial extends DeleteScoreState {}

class DeleteScoreDSucceed extends DeleteScoreState {
  
}

class DeleteScoreFailed extends DeleteScoreState {
  final ErrorModel error;

  const DeleteScoreFailed(this.error);
}

class DeleteScoreLoading extends DeleteScoreState {
  
}
