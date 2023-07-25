import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/score/domain/entities/test_score.dart';
import 'package:siakad_lpk/features/score/domain/usecase/get_test_score_usecase.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreBloc(this.testUseCase) : super(ScoreInitial()) {
    on<GetTestScoreEvent>(_onGetTestScoreEvent);
  }
  
  final GetTestScoreUseCase testUseCase;

  void _onGetTestScoreEvent(
    GetTestScoreEvent event,
    Emitter<ScoreState> emit,
  ) async {
    final result = await testUseCase(NoParams());
    result!.fold(
      (l) => emit(TestScoreFailed(ErrorModel(message: l.message))), 
      (r) => emit(TestScoreLoaded(r))
    );
  }

}
