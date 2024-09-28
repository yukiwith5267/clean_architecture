import 'package:app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/features/auth/presentation/pages/signin_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
        child: Text(
          'User ID: ${getIt<SupabaseClient>().auth.currentUser?.id ?? 'Not logged in'}',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  void _logout() async {
    await getIt<SupabaseClient>().auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SigninPage()),
    );
  }
}
