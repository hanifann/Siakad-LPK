import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/materi.dart';
import 'package:siakad_lpk/features/input_score/domain/usecases/get_materi_usecase.dart';

part 'materi_event.dart';
part 'materi_state.dart';

class MateriBloc extends Bloc<MateriEvent, MateriState> {
  MateriBloc(this.useCase) : super(MateriInitial()) {
    on<GetMateriEvent>(_onGetMateriEvent);
  }

  final GetMateriUseCase useCase;

  void _onGetMateriEvent(
    GetMateriEvent event,
    Emitter<MateriState> emit
  ) async {
    emit(MateriLoading());
    final result = await useCase(NoParams());
    result!.fold(
      (l) => emit(MateriFailed(ErrorModel(message: l.message))), 
      (r) => emit(MateriLoaded(r))
    );
  }

}
