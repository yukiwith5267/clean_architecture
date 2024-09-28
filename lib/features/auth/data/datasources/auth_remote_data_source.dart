import 'package:app/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<String> signUpWithEmailAndPassword(
      String name, String email, String password);
  Future<String> signInWithEmailAndPassword(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabase;
  AuthRemoteDataSourceImpl({required this.supabase});

  @override
  Future<String> signUpWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      final response =
          await supabase.auth.signUp(email: email, password: password, data: {
        'name': name,
      });
      if (response.user == null) {
        throw ServerException(message: 'User not found');
      }
      return response.user!.id;
    } catch (e) {
      // better to specify the type of error message
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final response = await supabase.auth
        .signInWithPassword(email: email, password: password);
    if (response.user == null) {
      throw ServerException(message: 'User not found');
    }
    return response.user!.id;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
