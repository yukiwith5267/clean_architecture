import 'package:app/core/secrets/app_secrets.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc(
          userSignUp: UserSignUp(
            authRepository: AuthRepositoryImpl(
              remoteDataSource: AuthRemoteDataSourceImpl(
                supabase: supabase.client,
              ),
            ),
          ),
          userSignIn: UserSignIn(
            authRepository: AuthRepositoryImpl(
              remoteDataSource: AuthRemoteDataSourceImpl(
                supabase: supabase.client,
              ),
            ),
          ),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: SignUpPage(),
    );
  }
}
