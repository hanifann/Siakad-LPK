import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/beranda/domain/entities/information.dart';
import 'package:siakad_lpk/features/beranda/domain/usecases/get_information_usecase.dart';

part 'information_event.dart';
part 'information_state.dart';

class InformationBloc extends Bloc<InformationEvent, InformationState> {
  InformationBloc({required this.useCase}) : super(InformationInitial()) {
    on<GetInformationEvent>(_onGetInformationEvent);
  }

  final GetInformationUseCase useCase;

  void _onGetInformationEvent(
    GetInformationEvent event,
    Emitter<InformationState> emit,
  ) async {
    emit(InformnationLoading());
    final result = await useCase(NoParams());
    result!.fold(
      (l) => emit(InformationFailed(ErrorModel(message: l.message))), 
      (r) => emit(InformationLoaded(r))
    );
  }
}
