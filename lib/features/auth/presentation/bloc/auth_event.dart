part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];

  get name => null;
}

class AuthSignUp extends AuthEvent {
  // ignore: annotate_overrides
  final String name;
  final String email;
  final String password;

  const AuthSignUp({required this.name, required this.email, required this.password});
}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  const AuthSignIn({required this.email, required this.password});
}