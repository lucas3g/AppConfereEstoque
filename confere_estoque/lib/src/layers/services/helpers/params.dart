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

class ProductEstoque {
  final String codigo;
  final int ccusto;

  ProductEstoque({
    required this.codigo,
    required this.ccusto,
  });
}

class EstoqueParams {
  final String codigo;
  final int ccusto;
  final String quantidade;
  final String tipoEstoque;

  EstoqueParams({
    required this.codigo,
    required this.ccusto,
    required this.quantidade,
    required this.tipoEstoque,
  });
}
