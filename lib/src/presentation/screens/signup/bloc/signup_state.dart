part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {
  final bool isShowPassword;
  final String? selectedRole;

  SignupInitial({this.isShowPassword = false, this.selectedRole});

  SignupInitial copyWith({bool? isShowPassword, String? selectedRole}) {
    return SignupInitial(
      isShowPassword: isShowPassword ?? this.isShowPassword,
      selectedRole: selectedRole ?? this.selectedRole,
    );
  }
}

final class SignupLoading extends SignupState {}

final class SignupFailure extends SignupState {
  final String error;

  SignupFailure({required this.error});
}

