// ignore_for_file: non_constant_identifier_names, overridden_fields

import 'dart:convert';

import 'package:confere_estoque/src/layers/domain/entities/product_entity.dart';

class ProductDto extends ProductEntity {
  @override
  String ID;
  @override
  String DESCRICAO;
  @override
  String SUCINTO;
  @override
  String UNIDADE;
  @override
  String SUBGRUPO;
  @override
  double VENDA;
  @override
  String? COMPOSICAO;
  @override
  String? APLICACAO;
  @override
  String SERVICO;
  @override
  String ATIVO;
  @override
  String? CODIGO_ORIGINAL;
  @override
  String? MARCA;
  @override
  String? MODELO;
  @override
  double CUSTO_ULTIMO;
  @override
  String? GTIN;
  @override
  double DESCONTO_MAX;
  @override
  double? EST_FISICO;
  @override
  double? EST_ATUAL;
  ProductDto({
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
    this.EST_FISICO = 0.0,
    this.EST_ATUAL = 0.0,
  }) : super(
          ID: ID,
          DESCRICAO: DESCRICAO,
          SUCINTO: SUCINTO,
          UNIDADE: UNIDADE,
          SUBGRUPO: SUBGRUPO,
          VENDA: VENDA,
          COMPOSICAO: COMPOSICAO,
          APLICACAO: APLICACAO,
          SERVICO: SERVICO,
          ATIVO: ATIVO,
          CODIGO_ORIGINAL: CODIGO_ORIGINAL,
          MARCA: MARCA,
          MODELO: MODELO,
          CUSTO_ULTIMO: CUSTO_ULTIMO,
          GTIN: GTIN,
          DESCONTO_MAX: DESCONTO_MAX,
          EST_FISICO: EST_FISICO,
          EST_ATUAL: EST_ATUAL,
        );

  ProductDto copyWith({
    String? ID,
    String? DESCRICAO,
    String? SUCINTO,
    String? UNIDADE,
    String? SUBGRUPO,
    double? VENDA,
    String? COMPOSICAO,
    String? APLICACAO,
    String? SERVICO,
    String? ATIVO,
    String? CODIGO_ORIGINAL,
    String? MARCA,
    String? MODELO,
    double? CUSTO_ULTIMO,
    String? GTIN,
    double? DESCONTO_MAX,
    double? EST_FISICO,
    double? EST_ATUAL,
  }) {
    return ProductDto(
      ID: ID ?? this.ID,
      DESCRICAO: DESCRICAO ?? this.DESCRICAO,
      SUCINTO: SUCINTO ?? this.SUCINTO,
      UNIDADE: UNIDADE ?? this.UNIDADE,
      SUBGRUPO: SUBGRUPO ?? this.SUBGRUPO,
      VENDA: VENDA ?? this.VENDA,
      COMPOSICAO: COMPOSICAO ?? this.COMPOSICAO,
      APLICACAO: APLICACAO ?? this.APLICACAO,
      SERVICO: SERVICO ?? this.SERVICO,
      ATIVO: ATIVO ?? this.ATIVO,
      CODIGO_ORIGINAL: CODIGO_ORIGINAL ?? this.CODIGO_ORIGINAL,
      MARCA: MARCA ?? this.MARCA,
      MODELO: MODELO ?? this.MODELO,
      CUSTO_ULTIMO: CUSTO_ULTIMO ?? this.CUSTO_ULTIMO,
      GTIN: GTIN ?? this.GTIN,
      DESCONTO_MAX: DESCONTO_MAX ?? this.DESCONTO_MAX,
      EST_FISICO: EST_FISICO ?? this.EST_FISICO,
      EST_ATUAL: EST_ATUAL ?? this.EST_ATUAL,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'DESCRICAO': DESCRICAO,
      'SUCINTO': SUCINTO,
      'UNIDADE': UNIDADE,
      'SUBGRUPO': SUBGRUPO,
      'VENDA': VENDA,
      'COMPOSICAO': COMPOSICAO,
      'APLICACAO': APLICACAO,
      'SERVICO': SERVICO,
      'ATIVO': ATIVO,
      'CODIGO_ORIGINAL': CODIGO_ORIGINAL,
      'MARCA': MARCA,
      'MODELO': MODELO,
      'CUSTO_ULTIMO': CUSTO_ULTIMO,
      'GTIN': GTIN,
      'DESCONTO_MAX': DESCONTO_MAX,
      'EST_FISICO': EST_FISICO,
      'EST_ATUAL': EST_ATUAL,
    };
  }

  factory ProductDto.fromMap(Map<String, dynamic> map) {
    return ProductDto(
      ID: map['ID'] ?? '',
      DESCRICAO: map['DESCRICAO'] ?? '',
      SUCINTO: map['SUCINTO'] ?? '',
      UNIDADE: map['UNIDADE'] ?? '',
      SUBGRUPO: map['SUBGRUPO'] ?? '',
      VENDA: map['VENDA']?.toDouble() ?? 0.0,
      COMPOSICAO: map['COMPOSICAO'] ?? '',
      APLICACAO: map['APLICACAO'] ?? '',
      SERVICO: map['SERVICO'] ?? '',
      ATIVO: map['ATIVO'] ?? '',
      CODIGO_ORIGINAL: map['CODIGO_ORIGINAL'] ?? '',
      MARCA: map['MARCA'] ?? '',
      MODELO: map['MODELO'] ?? '',
      CUSTO_ULTIMO: map['CUSTO_ULTIMO']?.toDouble() ?? 0.0,
      GTIN: map['GTIN'] ?? '',
      DESCONTO_MAX: map['DESCONTO_MAX']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDto.fromJson(String source) =>
      ProductDto.fromMap(json.decode(source));
}
