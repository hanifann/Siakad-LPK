import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/student_score.dart';
import 'package:siakad_lpk/features/input_score/domain/usecases/get_nilai_usecase.dart';

part 'get_score_event.dart';
part 'get_score_state.dart';

class GetScoreBloc extends Bloc<GetScoreEvent, GetScoreState> {
  GetScoreBloc(this.useCase) : super(GetScoreInitial()) {
    on<FetchScoreEvent>(_onFetchNilaiEvent);
  }

  final GetNilaiUseCase useCase;

  void _onFetchNilaiEvent(
    FetchScoreEvent event,
    Emitter<GetScoreState> emit,
  ) async {
    emit(GetScoreLoading());
    final result = await useCase(
      GetNilaiParams(event.idMateri)
    );
    result!.fold(
      (l) => emit(GetScoreFailed(ErrorModel(message: l.message))), 
      (r) => emit(GetScoreLoaded(r))
    );
  }
}
