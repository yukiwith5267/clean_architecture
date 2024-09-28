import 'package:app/core/theme/theme.dart';
import 'package:app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/features/auth/presentation/pages/signup_page.dart';
import 'package:app/features/auth/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/init_dependencies.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => getIt<AuthBloc>(),
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
      home: _checkAuthState(),
    );
  }

  Widget _checkAuthState() {
    final client = getIt<SupabaseClient>();
    final session = client.auth.currentSession;
    // ignore: unnecessary_null_comparison
    if (session != null && session.user != null) {
      return const HomePage();
    } else {
      return const SignUpPage();
    }
  }
}
