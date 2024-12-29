
import 'package:cricket_app/src/presentation/common_blocs/auth/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthBloc authBloc;
  SignupBloc({required this.authBloc}) : super(SignupInitial()) {
    ///Handles sign up actions
    on<SignupButtonPressed>((event, emit) async {
      emit(SignupLoading());
      try {
        authBloc.add(SignUpEvent(event.email, event.password, event.role, event.name));
        await for (final state in authBloc.stream) {
          if (state is AuthAuthenticated) {
            emit(SignupInitial());
            break;
          } else if (state is AuthError) {
            emit(SignupFailure(error: state.message));
            break;
          }
        }
      } catch (error) {
        emit(SignupFailure(error: error.toString()));
      }
    });

    ///Handles password visibility
    on<TogglePasswordVisibility>((event, emit) {
      if (state is SignupInitial) {
        final currentState = state as SignupInitial;
        emit(currentState.copyWith(isShowPassword: !currentState.isShowPassword));
      }
    });
    ///Handles Role Selection buttons
    on<RoleSelected>((event, emit) {
      if (state is SignupInitial) {
        final currentState = state as SignupInitial;
        emit(currentState.copyWith(selectedRole: event.role));
      }
    });
  }
}
