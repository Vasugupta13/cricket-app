
enum UserRole {
  operator("operator"),
  user("user");

  const UserRole(this.value);
  final String value;
}