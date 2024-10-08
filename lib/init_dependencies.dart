import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/core/secrets/app_secrets.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  getIt
    ..registerSingleton<SupabaseClient>(supabase.client)
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(supabase: getIt<SupabaseClient>()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: getIt<AuthRemoteDataSource>()),
    )
    ..registerLazySingleton<UserSignUp>(
      () => UserSignUp(authRepository: getIt<AuthRepository>()),
    )
    ..registerLazySingleton<UserSignIn>(
      () => UserSignIn(authRepository: getIt<AuthRepository>()),
    )
    ..registerFactory<AuthBloc>(
      () => AuthBloc(
        userSignUp: getIt<UserSignUp>(),
        userSignIn: getIt<UserSignIn>(),
      ),
    );
}
