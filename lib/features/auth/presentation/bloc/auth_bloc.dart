import 'package:app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp userSignUp;
  AuthBloc({required this.userSignUp}) : super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final result = await userSignUp.call(UserSignUpParams(
          name: event.name, email: event.email, password: event.password));
      result.fold((l) => emit(AuthFailure(message: l.message)),
          (r) => emit(AuthSuccess(uid: r)));
    });
  }
}
