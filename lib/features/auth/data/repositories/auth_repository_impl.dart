import 'package:app/core/error/exception.dart';
import 'package:app/core/error/failures.dart';
import 'package:app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, String>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDataSource.signUpWithEmailAndPassword(name, email, password);
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDataSource.signInWithEmailAndPassword(email, password);
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}