import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_lpk/core/error/model/error_model.dart';
import 'package:siakad_lpk/features/register/data/models/register_model.dart';
import 'package:siakad_lpk/features/register/domain/usecases/post_register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required this.useCase}) : super(RegisterInitial()) {
    on<PostRegisterEvent>(_onPostRegisterEvent);
  }

  final PostRegisterUseCase useCase;

  void _onPostRegisterEvent(
    PostRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    final result = await useCase(
      RegisterParams(
        fullName: event.register.fullName, 
        email: event.register.email, 
        password: event.register.password, 
        image: event.register.image, 
        ktp: event.register.ktp, 
        kontak: event.register.kontak, 
        kelas: event.register.kelas, 
        alamat: event.register.alamat, 
        tempatLahir: event.register.tempatLahir, 
        tglLahir: event.register.tglLahir, 
        pendidikanTerakhir: event.register.pendidikanTerakhir, 
        status: event.register.status, 
        agama: event.register.agama, 
        namaOrtu: event.register.namaOrtu, 
        pengalaman: event.register.pengalaman, 
        metodeBayar: event.register.metodeBayar, 
        buktiBayar: event.register.buktiBayar
      )
    );
    result!.fold(
      (l) => emit(RegisterFailed(ErrorModel(message: l.message))), 
      (r) => emit(RegisterSucceed())
    );
  }
}
