import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/score/domain/entities/lpk_score.dart';
import 'package:siakad_lpk/features/score/domain/usecase/get_lpk_score_usecase.dart';

part 'lpk_score_event.dart';
part 'lpk_score_state.dart';

class LpkScoreBloc extends Bloc<LpkScoreEvent, LpkScoreState> {
  LpkScoreBloc(this.useCase) : super(LpkScoreInitial()) {
    on<GetLpkScoreEvent>(_onGetLpkScoreEvent);
  }

  final GetLpkScoreUseCase useCase;

  void _onGetLpkScoreEvent(
    GetLpkScoreEvent event,
    Emitter<LpkScoreState> emit,
  ) async {
    emit(LpkScoreLoading());
    final result = await useCase(NoParams());
    result!.fold(
      (l) => emit(LpkScoreFailed(ErrorModel(message: l.message))), 
      (r) => emit(LpkScoreLoaded(r))
    );
  }
}
