import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/features/login/domain/entities/login.dart';
import 'package:siakad_lpk/features/login/domain/usecases/post_login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.useCase}) : super(LoginInitial()) {
    on<PostLoginEvent>(_onPostLoginEvent);
  }
  final PostLoginUseCase useCase;

  void _onPostLoginEvent(
    PostLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final result = await useCase(
      LoginParams(event.email, event.password)
    );
    result!.fold(
      (l) => emit(LoginFailed(ErrorModel(message: l.message))), 
      (r) => emit(LoginSucceed(r))
    );
  }

}
