import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/features/input_score/domain/usecases/delete_nilai_usecase.dart';

part 'delete_score_event.dart';
part 'delete_score_state.dart';

class DeleteScoreBloc extends Bloc<DeleteScoreEvent, DeleteScoreState> {
  DeleteScoreBloc(this.useCase) : super(DeleteScoreInitial()) {
    on<DeleteNilai>(_onDeleteNilai);
  }

  final DeleteNilaiUseCase useCase;

  void _onDeleteNilai(
    DeleteNilai event,
    Emitter<DeleteScoreState> emit,
  ) async {
    emit(DeleteScoreLoading());
    final result = await useCase(
      DeleteNilaiParams(event.idNilai)
    );
    result!.fold(
      (l) => emit(DeleteScoreFailed(ErrorModel(message: l.message))), 
      (r) => emit(DeleteScoreDSucceed())
    );
  }
  
}
