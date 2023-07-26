part of 'delete_score_bloc.dart';

abstract class DeleteScoreEvent extends Equatable {
  const DeleteScoreEvent();

  @override
  List<Object> get props => [];
}

class DeleteNilai extends DeleteScoreEvent {
  final String idNilai;

  const DeleteNilai(this.idNilai);
}
