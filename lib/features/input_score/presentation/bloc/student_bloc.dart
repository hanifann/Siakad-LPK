import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/student.dart';
import 'package:siakad_lpk/features/input_score/domain/usecases/get_student_usecase.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc(this.useCase) : super(StudentInitial()) {
    on<GetStudentEvent>(_onGetStudentEvent);
  }

  final GetStudentUseCase useCase;

  void _onGetStudentEvent(
    GetStudentEvent event,
    Emitter<StudentState> emit
  ) async {
    emit(StudentLoading());
    final result = await useCase(NoParams());
    result!.fold(
      (l) => emit(StudentFailed(ErrorModel(message: l.message))), 
      (r) => emit(StudentLoaded(r))
    );
  }
}
