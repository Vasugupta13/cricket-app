part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignupButtonPressed extends SignupEvent {
  final String email;
  final String password;
  final String name;
  final String role;

  SignupButtonPressed(
      {required this.email,
      required this.password,
      required this.name,
      required this.role});
}
class TogglePasswordVisibility extends SignupEvent {}

class RoleSelected extends SignupEvent {
  final String role;

  RoleSelected({required this.role});
}