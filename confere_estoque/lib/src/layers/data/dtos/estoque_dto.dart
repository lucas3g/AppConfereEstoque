// ignore_for_file: non_constant_identifier_names, overridden_fields

import 'dart:convert';

import 'package:confere_estoque/src/layers/domain/entities/estoque_entity.dart';

class EstoqueDto extends EstoqueEntity {
  @override
  int? CCUSTO;
  @override
  String? MERCADORIA;
  @override
  String? DATA;
  @override
  double? QTD_NOVO;
  @override
  double? QTD_ANTES;
  @override
  double? QTD_AJUSTADO;
  @override
  String? AJUSTADO;
  @override
  String? CONTABIL_FISICO;

  EstoqueDto({
    required this.CCUSTO,
    required this.MERCADORIA,
    required this.DATA,
    required this.QTD_NOVO,
    required this.QTD_ANTES,
    this.QTD_AJUSTADO,
    required this.AJUSTADO,
    required this.CONTABIL_FISICO,
  }) : super(
          CCUSTO: CCUSTO,
          MERCADORIA: MERCADORIA,
          DATA: DATA,
          QTD_NOVO: QTD_NOVO,
          QTD_ANTES: QTD_ANTES,
          QTD_AJUSTADO: QTD_AJUSTADO,
          AJUSTADO: AJUSTADO,
          CONTABIL_FISICO: CONTABIL_FISICO,
        );

  Map<String, dynamic> toMap() {
    return {
      'CCUSTO': CCUSTO,
      'MERCADORIA': MERCADORIA,
      'DATA': DATA,
      'QTD_NOVO': QTD_NOVO,
      'QTD_ANTES': QTD_ANTES,
      'QTD_AJUSTADO': QTD_AJUSTADO,
      'AJUSTADO': AJUSTADO,
      'CONTABIL_FISICO': CONTABIL_FISICO,
    };
  }

  static EstoqueDto fromMap(Map map) {
    return EstoqueDto(
      CCUSTO: map['CCUSTO'],
      MERCADORIA: map['MERCADORIA'],
      DATA: map['DATA'],
      QTD_NOVO: map['QTD_NOVO']?.toDouble() ?? 0.0,
      QTD_ANTES: map['QTD_ANTES']?.toDouble() ?? 0.0,
      QTD_AJUSTADO: map['QTD_AJUSTADO']?.toDouble() ?? 0.0,
      AJUSTADO: map['AJUSTADO'],
      CONTABIL_FISICO: map['CONTABIL_FISICO'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EstoqueDto.fromJson(String source) =>
      EstoqueDto.fromMap(json.decode(source));
}
