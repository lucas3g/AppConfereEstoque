// ignore_for_file: non_constant_identifier_names

class ProductEntity {
  final String ID;
  final String DESCRICAO;
  final String SUCINTO;
  final String UNIDADE;
  final String SUBGRUPO;
  final double VENDA;
  String? COMPOSICAO;
  String? APLICACAO;
  final String SERVICO;
  final String ATIVO;
  final String? CODIGO_ORIGINAL;
  String? MARCA;
  String? MODELO;
  final double CUSTO_ULTIMO;
  String? GTIN;
  final double DESCONTO_MAX;
  double? EST_FISICO;
  double? EST_ATUAL;

  ProductEntity({
    required this.ID,
    required this.DESCRICAO,
    required this.SUCINTO,
    required this.UNIDADE,
    required this.SUBGRUPO,
    required this.VENDA,
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
    this.EST_FISICO,
    this.EST_ATUAL,
  });
}
