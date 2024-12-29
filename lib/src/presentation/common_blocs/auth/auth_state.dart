import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  final String role;

  AuthAuthenticated(this.user, this.role);
}
class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}