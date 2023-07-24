import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/core/usecase/usecase.dart';
import 'package:siakad_lpk/features/login/domain/entities/user.dart';
import 'package:siakad_lpk/features/login/domain/usecases/get_local_user_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.useCase, this.preferences) 
    : super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfileEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  final GetLocalUserUseCase useCase;
  final SharedPreferences preferences;

  void _onGetProfileEvent(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await useCase(NoParams());
    result!.fold(
      (l) => emit(ProfileFailed(ErrorModel(message: l.message))), 
      (r) => emit(ProfileLoaded(r))
    );
  }

  void _onLogoutEvent(
    LogoutEvent event,
    Emitter<ProfileState> emit,
  ) async {
    await preferences.clear();
    emit(LogoutSuccess());
  }
}
