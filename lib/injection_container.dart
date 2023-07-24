import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_lpk/core/platform/network_info.dart';
import 'package:siakad_lpk/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:siakad_lpk/features/login/data/datasources/login_local_datasources.dart';
import 'package:siakad_lpk/features/login/data/datasources/login_remote_datasource.dart';
import 'package:siakad_lpk/features/login/data/repositories/login_repository_impl.dart';
import 'package:siakad_lpk/features/login/domain/repositories/login_repositort.dart';
import 'package:siakad_lpk/features/login/domain/usecases/get_local_user_usecase.dart';
import 'package:siakad_lpk/features/login/domain/usecases/get_user_usecase.dart';
import 'package:siakad_lpk/features/login/domain/usecases/post_login_usecase.dart';
import 'package:siakad_lpk/features/login/presentation/bloc/login_bloc.dart';
import 'package:siakad_lpk/features/login/presentation/bloc/user_bloc.dart';
import 'package:siakad_lpk/features/profile/presentation/bloc/profile_bloc.dart';
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

  //login
  //bloc
  sl.registerFactory(() => LoginBloc(useCase: sl()));
  sl.registerFactory(() => UserBloc(useCase: sl()));
  //usecases
  sl.registerLazySingleton(() => PostLoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetLocalUserUseCase(repository: sl()));
  //repositories
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
    networkInfo: sl(), 
    remoteDataSource: sl(), 
    localDataSource: sl()
  ));
  //datasources
  sl.registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl(
    client: sl(), 
    preferences: sl()
  ));
   sl.registerLazySingleton<LoginLocalDataSource>(() => LoginLocalDataSourceImpl(
    preferences: sl()
  ));

  //auth
  //cubit
  sl.registerFactory(() => AuthCubit(sl(), sl()));

  //profile
  //bloc
  sl.registerFactory(() => ProfileBloc(sl(), sl()));


  //!core
  final prefs = await SharedPreferences.getInstance();
  final client = Client();
  sl.registerLazySingleton(() => client);
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}