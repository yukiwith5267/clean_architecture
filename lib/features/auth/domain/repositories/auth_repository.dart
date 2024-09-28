import 'package:app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  // Either<Failure, String> purpose is to manage errors effectively at the data layer.
  Future<Either<Failure, String>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, String>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}