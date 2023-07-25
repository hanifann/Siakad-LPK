import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_lpk/core/platform/network_info.dart';
import 'package:siakad_lpk/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:siakad_lpk/features/beranda/data/datasources/information_local_datasource.dart';
import 'package:siakad_lpk/features/beranda/data/datasources/information_remote_datasources.dart';
import 'package:siakad_lpk/features/beranda/data/repositories/information_repository_impl.dart';
import 'package:siakad_lpk/features/beranda/domain/repositories/information_repository.dart';
import 'package:siakad_lpk/features/beranda/domain/usecases/get_information_usecase.dart';
import 'package:siakad_lpk/features/beranda/presentation/bloc/information_bloc.dart';
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
import 'package:siakad_lpk/features/schedule/data/datasources/schedule_local_datasource.dart';
import 'package:siakad_lpk/features/schedule/data/datasources/schedule_remote_datasource.dart';
import 'package:siakad_lpk/features/schedule/data/repositories/schedule_repository_impl.dart';
import 'package:siakad_lpk/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:siakad_lpk/features/schedule/domain/usecases/get_schedule_usecase.dart';
import 'package:siakad_lpk/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:siakad_lpk/features/score/data/datasources/score_local_datasources.dart';
import 'package:siakad_lpk/features/score/data/datasources/score_remote_datasources.dart';
import 'package:siakad_lpk/features/score/data/repositories/score_repository_impl.dart';
import 'package:siakad_lpk/features/score/domain/repositories/score_repository.dart';
import 'package:siakad_lpk/features/score/domain/usecase/get_lpk_score_usecase.dart';
import 'package:siakad_lpk/features/score/domain/usecase/get_test_score_usecase.dart';
import 'package:siakad_lpk/features/score/presentation/bloc/lpk_score_bloc.dart';
import 'package:siakad_lpk/features/score/presentation/bloc/score_bloc.dart';

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


  //beranda
  //bloc
  sl.registerFactory(() => InformationBloc(useCase: sl()));
  //usecases
  sl.registerLazySingleton(() => GetInformationUseCase(repository: sl()));
  //repositoies
  sl.registerLazySingleton<InformationRepository>(
    () => InformationRepositoryImpl(networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl())
  );
  //datasources
  sl.registerLazySingleton<InformationRemoteDataSource>(
    () => InformationRemoteDataSourceImpl(client: sl(), preferences: sl())
  );
  sl.registerLazySingleton<InformationLocalDataSource>(
    () => InformationLocalDataSourceImpl(preferences: sl())
  );

  //schedule
  //bloc
  sl.registerFactory(() => ScheduleBloc(sl()));
  //usecases
  sl.registerLazySingleton(() => GetScheduleUseCase(sl()));
  //repositories
  sl.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepositoryImpl(sl(), sl(), sl())
  );
  //datasources
  sl.registerLazySingleton<ScheduleRemoteDataSource>(
    () => ScheduleRemoteDataSourceImpl(sl(), sl())
  );
  sl.registerLazySingleton<ScheduleLocalDataSource>(
    () => ScheduleLocalDataSourceImpl(sl())
  );

  //score
  //bloc
  sl.registerFactory(() => ScoreBloc(sl()));
  sl.registerFactory(() => LpkScoreBloc(sl()));
  //usecases
  sl.registerLazySingleton(() => GetLpkScoreUseCase(sl()));
  sl.registerLazySingleton(() => GetTestScoreUseCase(sl()));
  //repositories
  sl.registerLazySingleton<ScoreRepository>(
    () => ScoreRepositoryImpl(sl(), sl(), sl())
  );
  //datasources
  sl.registerLazySingleton<ScoreRemoteDataSource>(
    () => ScoreRemoteDataSourceImpl(sl(), sl())
  );
  sl.registerLazySingleton<ScoreLocalDataSource>(
    () => ScoreLocalDataSourceImpl(sl())
  );


  //!core
  final prefs = await SharedPreferences.getInstance();
  final client = Client();
  sl.registerLazySingleton(() => client);
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}