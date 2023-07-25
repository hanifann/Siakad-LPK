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

class LpkScoreLoaded extends ScoreState {
  final LpkScore lpkScore;

  const LpkScoreLoaded(this.lpkScore);
}

class ScoreFailed extends ScoreState {
  final ErrorModel error;

  const ScoreFailed(this.error);
}

class ScoreLoading extends ScoreState {
  
}
