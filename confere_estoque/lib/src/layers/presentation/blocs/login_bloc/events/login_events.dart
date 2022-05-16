abstract class LoginEvents {}

class LoginSignInEvent extends LoginEvents {
  final String cnpj;
  final String login;
  final String password;
  LoginSignInEvent({
    required this.cnpj,
    required this.login,
    required this.password,
  });
}
