part of 'lpk_score_bloc.dart';

abstract class LpkScoreState extends Equatable {
  const LpkScoreState();
  
  @override
  List<Object> get props => [];
}

class LpkScoreInitial extends LpkScoreState {}

class LpkScoreFailed extends LpkScoreState {
  final ErrorModel error;

  const LpkScoreFailed(this.error);
}

class LpkScoreLoaded extends LpkScoreState {
  final LpkScore lpkScore;

  const LpkScoreLoaded(this.lpkScore);
}

class LpkScoreLoading extends LpkScoreState {
  
}
