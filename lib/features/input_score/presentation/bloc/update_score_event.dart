part of 'update_score_bloc.dart';

abstract class UpdateScoreEvent extends Equatable {
  const UpdateScoreEvent();

  @override
  List<Object> get props => [];
}

class UpdateNilaiEvent extends UpdateScoreEvent {
  final String idNilai;
  final String idSiswa;
  final String idMateri;
  final String nilai;

  const UpdateNilaiEvent(this.idNilai, this.idSiswa, this.idMateri, this.nilai);
}
