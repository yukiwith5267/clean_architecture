import 'package:app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp userSignUp;
  final UserSignIn userSignIn;
  AuthBloc({required this.userSignUp, required this.userSignIn})
      : super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
  }

  Future<void> _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await userSignUp.call(UserSignUpParams(
          name: event.name, email: event.email, password: event.password));
      result.fold((l) => emit(AuthFailure(message: l.message)),
          (r) => emit(AuthSuccess(uid: r)));
  }

  Future<void> _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
      final result = await userSignIn
          .call(UserSignInParams(email: event.email, password: event.password));
      result.fold((l) => emit(AuthFailure(message: l.message)),
          (r) => emit(AuthSuccess(uid: r)));
  }
}
