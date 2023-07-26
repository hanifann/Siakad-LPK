part of 'input_score_bloc.dart';

abstract class InputScoreState extends Equatable {
  const InputScoreState();
  
  @override
  List<Object> get props => [];
}

class InputScoreInitial extends InputScoreState {}

class InputScorSucceed extends InputScoreState {
  
}

class InputScoreFailed extends InputScoreState {
  final ErrorModel error;

  const InputScoreFailed(this.error);
}

class InputScoreLoading extends InputScoreState {
  
}