class LoginParams {
  final String cnpj;
  final String login;
  final String password;

  LoginParams({
    required this.cnpj,
    required this.login,
    required this.password,
  });
}

class ProductParams {
  final String codigo;
  final int ccusto;

  ProductParams({
    required this.codigo,
    required this.ccusto,
  });
}
