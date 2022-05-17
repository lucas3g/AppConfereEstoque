// ignore_for_file: non_constant_identifier_names, overridden_fields

import 'dart:convert';

import 'package:confere_estoque/src/layers/domain/entities/ccustos_entity.dart';

class CCustosDto extends CCustosEntity {
  @override
  int ID;
  @override
  String DESCRICAO;
  @override
  int LOCAL;
  @override
  String ESTOQUE_ZERO;
  @override
  String ESTOQUE_CONTROLA;
  @override
  String ATIVO;
  @override
  String NRSERIE_CONTROLA;

  CCustosDto({
    required this.ID,
    required this.DESCRICAO,
    required this.LOCAL,
    required this.ESTOQUE_ZERO,
    required this.ESTOQUE_CONTROLA,
    required this.ATIVO,
    required this.NRSERIE_CONTROLA,
  }) : super(
          ID: ID,
          DESCRICAO: DESCRICAO,
          LOCAL: LOCAL,
          ESTOQUE_ZERO: ESTOQUE_ZERO,
          ESTOQUE_CONTROLA: ESTOQUE_CONTROLA,
          ATIVO: ATIVO,
          NRSERIE_CONTROLA: NRSERIE_CONTROLA,
        );

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'DESCRICAO': DESCRICAO,
      'LOCAL': LOCAL,
      'ESTOQUE_ZERO': ESTOQUE_ZERO,
      'ESTOQUE_CONTROLA': ESTOQUE_CONTROLA,
      'ATIVO': ATIVO,
      'NRSERIE_CONTROLA': NRSERIE_CONTROLA,
    };
  }

  static CCustosDto fromMap(Map map) {
    return CCustosDto(
      ID: map['ID'],
      DESCRICAO: map['DESCRICAO'],
      LOCAL: map['LOCAL'],
      ESTOQUE_ZERO: map['ESTOQUE_ZERO'] ?? '',
      ESTOQUE_CONTROLA: map['ESTOQUE_CONTROLA'] ?? 101,
      ATIVO: map['ATIVO'] ?? '',
      NRSERIE_CONTROLA: map['NRSERIE_CONTROLA'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CCustosDto.fromJson(String source) =>
      CCustosDto.fromMap(json.decode(source));
}
