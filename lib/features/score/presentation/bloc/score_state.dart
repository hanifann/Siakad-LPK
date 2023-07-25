part of 'score_bloc.dart';

abstract class ScoreState extends Equatable {
  const ScoreState();
  
  @override
  List<Object> get props => [];
}

class ScoreInitial extends ScoreState {}

class TestScoreLoaded extends ScoreState {
  final TestScore testScore;

  const TestScoreLoaded(this.testScore);
}

class TestScoreFailed extends ScoreState {
  final ErrorModel error;

  const TestScoreFailed(this.error);
}

class TestScoreLoading extends ScoreState {
  
}
