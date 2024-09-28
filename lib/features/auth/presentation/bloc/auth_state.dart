part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String uid;

  const AuthSuccess({required this.uid});
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});
}
