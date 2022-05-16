// ignore_for_file: non_constant_identifier_names

class ProductEntity {
  final String ID_MERCADORIA;
  final String DESCRICAO;
  final String SUCINTO;
  final String UNIDADE;
  final String SUBGRUPO;
  final double VALOR_VENDA;
  final String? COMPOSICAO;
  final String? APLICACAO;
  final String SERVICO;
  final String ATIVO;
  final String? CODIGO_ORIGINAL;
  final String? MARCA;
  final String? MODELO;
  final double CUSTO_ULTIMO;
  final String? GTIN;
  final double DESCONTO_MAX;

  ProductEntity({
    required this.ID_MERCADORIA,
    required this.DESCRICAO,
    required this.SUCINTO,
    required this.UNIDADE,
    required this.SUBGRUPO,
    required this.VALOR_VENDA,
    this.COMPOSICAO,
    this.APLICACAO,
    required this.SERVICO,
    required this.ATIVO,
    this.CODIGO_ORIGINAL,
    this.MARCA,
    this.MODELO,
    required this.CUSTO_ULTIMO,
    this.GTIN,
    required this.DESCONTO_MAX,
  });
}
