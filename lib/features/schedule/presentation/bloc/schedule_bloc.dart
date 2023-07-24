import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/schedule/domain/entities/schedule.dart';
import 'package:siakad_lpk/features/schedule/domain/usecases/get_schedule_usecase.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc(this.useCase) : super(ScheduleInitial()) {
    on<GetScheduleEvent>(_onGetScheduleEvent);
  }

  final GetScheduleUseCase useCase;

  void _onGetScheduleEvent(
    GetScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    final result = await useCase(NoParams());
    result!.fold(
      (l) => emit(ScheduleFailed(ErrorModel(message: l.message))), 
      (r) => emit(ScheduleLoaded(r))
    );
  }
}
