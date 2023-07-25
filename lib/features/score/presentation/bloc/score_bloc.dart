import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/score/domain/entities/lpk_score.dart';
import 'package:siakad_lpk/features/score/domain/entities/test_score.dart';
import 'package:siakad_lpk/features/score/domain/usecase/get_lpk_score_usecase.dart';
import 'package:siakad_lpk/features/score/domain/usecase/get_test_score_usecase.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreBloc(this.lpkUseCase, this.testUseCase) : super(ScoreInitial()) {
    on<GetLpkScoreEvent>(_onGetLpkScoreEvent);
    on<GetTestScoreEvent>(_onGetTestScoreEvent);
  }
  
  final GetLpkScoreUseCase lpkUseCase;
  final GetTestScoreUseCase testUseCase;

  void _onGetLpkScoreEvent(
    GetLpkScoreEvent event,
    Emitter<ScoreState> emit,
  ) async {
    emit(ScoreLoading());
    final result = await lpkUseCase(NoParams());
    result!.fold(
      (l) => emit(ScoreFailed(ErrorModel(message: l.message))), 
      (r) => emit(LpkScoreLoaded(r))
    );
  }

  void _onGetTestScoreEvent(
    GetTestScoreEvent event,
    Emitter<ScoreState> emit,
  ) async {
    emit(ScoreLoading());
    final result = await testUseCase(NoParams());
    result!.fold(
      (l) => emit(ScoreFailed(ErrorModel(message: l.message))), 
      (r) => emit(TestScoreLoaded(r))
    );
  }

}
