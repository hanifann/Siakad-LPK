part of 'input_score_bloc.dart';

abstract class InputScoreEvent extends Equatable {
  const InputScoreEvent();

  @override
  List<Object> get props => [];
}

class PostInputScoreEvent extends InputScoreEvent {
  final String idSiswa;
  final String idMateri;
  final String nilai;

  const PostInputScoreEvent({
    required this.idSiswa, 
    required this.idMateri, 
    required this.nilai
  });
}
