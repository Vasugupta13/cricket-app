import 'package:cricket_app/src/data/repository/auth_repo.dart';
import 'package:cricket_app/src/presentation/common_blocs/auth/auth_state.dart';
import 'package:cricket_app/src/presentation/common_blocs/auth/auth_event.dart';
import 'package:cricket_app/src/utils/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  ///BLOC for authentication
  ///
  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        if(!UtilValidators.isValidEmail(event.email)){
          emit(AuthError("Email is invalid"));
          return;
        }
        if(!UtilValidators.isValidPassword(event.password)){
          emit(AuthError("Password is invalid"));
          return;
        }
        final user = await _authRepository.signUp(event.email, event.password, event.role, event.name );
        final role = await _authRepository.getUserRole(user!.uid);
        emit(AuthAuthenticated(user, role!));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    ///[SignInEvent] triggered when user signs in
    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        if(!UtilValidators.isValidEmail(event.email)){
          emit(AuthError("Email is invalid"));
          return;
        }
        if(!UtilValidators.isValidPassword(event.password)){
          emit(AuthError("Password is invalid"));
          return;
        }
        final user = await _authRepository.signIn(event.email, event.password);
        final role = await _authRepository.getUserRole(user!.uid);
        emit(AuthAuthenticated(user, role!));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    ///[SignOutEvent] triggered when user signs out
    on<SignOutEvent>((event, emit) async {
      emit(AuthLoading());
      await _authRepository.signOut();
      emit(AuthUnauthenticated());
    });

    ///[CheckAuthEvent] Check auth status
    on<CheckAuthEvent>((event, emit) async {
      final user = _authRepository.getCurrentUser();
      if (user != null) {
        final role = await _authRepository.getUserRole(user.uid);
        emit(AuthAuthenticated(user, role!));
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }
}