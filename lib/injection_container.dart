import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_lpk/core/platform/network_info.dart';
import 'package:siakad_lpk/features/register/data/datasources/register_remote_datasources.dart';
import 'package:siakad_lpk/features/register/data/repositories/register_repository_impl.dart';
import 'package:siakad_lpk/features/register/domain/repositories/register_repository.dart';
import 'package:siakad_lpk/features/register/domain/usecases/post_register_usecase.dart';
import 'package:siakad_lpk/features/register/presentation/bloc/register_bloc.dart';

final sl =GetIt.instance;

Future<void> init() async {
  //!features
  //register
  //bloc
  sl.registerFactory(() => RegisterBloc(useCase: sl()));
  //usecases
  sl.registerLazySingleton(() => PostRegisterUseCase(repository: sl()));
  //repositories
  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImpl(
    networkInfo: sl(), 
    remoteDataSource: sl()
  ));
  //datasouces
  sl.registerLazySingleton<RegisterRemoteDataSource>(
    () => RegisterRemoteDataSourceImpl(client: sl())
  );


  //!core
  final prefs = await SharedPreferences.getInstance();
  final client = Client();
  sl.registerLazySingleton(() => client);
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}