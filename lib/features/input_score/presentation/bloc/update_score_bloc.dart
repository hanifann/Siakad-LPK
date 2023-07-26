import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/features/input_score/domain/usecases/edit_nilai_usecase.dart';

part 'update_score_event.dart';
part 'update_score_state.dart';

class UpdateScoreBloc extends Bloc<UpdateScoreEvent, UpdateScoreState> {
  UpdateScoreBloc(this.useCase) : super(UpdateScoreInitial()) {
    on<UpdateNilaiEvent>(_onUpdateNilai);
  }

  final EditNilaiUseCase useCase;

  void _onUpdateNilai(
    UpdateNilaiEvent event,
    Emitter<UpdateScoreState> emit,
  ) async {
    emit(UpdateScoreLoading());
    final result = await useCase(
      EditNilaiParams(
        idNilai: event.idNilai, 
        idSiswa: event.idSiswa, 
        idMateri: event.idMateri, 
        nilai: event.nilai
      )
    );
    result!.fold(
      (l) => emit(UpdateScoreFailed(ErrorModel(message: l.message))), 
      (r) => emit(UpdateScoreSucceed())
    );
  }
}
