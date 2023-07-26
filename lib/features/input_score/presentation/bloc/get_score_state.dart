part of 'get_score_bloc.dart';

abstract class GetScoreState extends Equatable {
  const GetScoreState();
  
  @override
  List<Object> get props => [];
}

class GetScoreInitial extends GetScoreState {}

class GetScoreLoaded extends GetScoreState {
  final StudentScore score;

  const GetScoreLoaded(this.score);
}

class GetScoreFailed extends GetScoreState {
  final ErrorModel error;

  const GetScoreFailed(this.error);
}

class GetScoreLoading extends GetScoreState {
  
}
