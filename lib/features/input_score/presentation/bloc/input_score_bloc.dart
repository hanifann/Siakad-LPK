import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/features/input_score/domain/usecases/post_nilai_usecase.dart';

part 'input_score_event.dart';
part 'input_score_state.dart';

class InputScoreBloc extends Bloc<InputScoreEvent, InputScoreState> {
  InputScoreBloc(this.useCase) : super(InputScoreInitial()) {
    on<PostInputScoreEvent>(_onPostNilaiEvent);
  }

  final PostNilaiUseCase useCase;

  void _onPostNilaiEvent(
    PostInputScoreEvent event,
    Emitter<InputScoreState> emit,
  ) async {
    emit(InputScoreLoading());
    final result = await useCase(
      NilaiParams(
        idMateri: event.idMateri, 
        idSiswa: event.idSiswa, 
        nilai: event.nilai
      )
    );
    result!.fold(
      (l) => emit(InputScoreFailed(ErrorModel(message: l.message))), 
      (r) => emit(InputScorSucceed())
    );
  }
}
