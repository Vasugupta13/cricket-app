
abstract class AuthEvent {}

class CheckAuthEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String role;
  final String name;

  SignUpEvent(this.email, this.password, this.role, this.name);
}
class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}

class SignOutEvent extends AuthEvent {}

