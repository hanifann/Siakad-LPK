part of 'get_score_bloc.dart';

abstract class GetScoreEvent extends Equatable {
  const GetScoreEvent();

  @override
  List<Object> get props => [];
}

class FetchScoreEvent extends GetScoreEvent{
  final String idMateri;

  const FetchScoreEvent(this.idMateri);
}
