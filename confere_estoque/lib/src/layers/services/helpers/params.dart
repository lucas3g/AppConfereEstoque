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
  final String descricao;
  final int ccusto;

  ProductParams({
    required this.codigo,
    required this.descricao,
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
  final double quantidade;
  final String tipoEstoque;
  final double qtdAntes;

  EstoqueParams({
    required this.codigo,
    required this.ccusto,
    required this.quantidade,
    required this.qtdAntes,
    required this.tipoEstoque,
  });
}
