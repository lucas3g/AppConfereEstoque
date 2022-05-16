// ignore_for_file: non_constant_identifier_names, overridden_fields

import 'dart:convert';

import 'package:confere_estoque/src/layers/domain/entities/user_entity.dart';

class UserDto extends UserEntity {
  @override
  int ID;
  @override
  int NFCE_CAIXA;
  @override
  String NOME;
  @override
  String? CODFRENTISTA;
  @override
  int? CCUSTO;
  @override
  String? E_MAIL;
  @override
  int? CARTEIRA_CLIENTE;

  UserDto({
    required this.ID,
    required this.NFCE_CAIXA,
    required this.NOME,
    this.CODFRENTISTA,
    this.CCUSTO,
    this.E_MAIL,
    this.CARTEIRA_CLIENTE,
  }) : super(
          ID: ID,
          NFCE_CAIXA: NFCE_CAIXA,
          NOME: NOME,
          CODFRENTISTA: CODFRENTISTA,
          CCUSTO: CCUSTO,
          E_MAIL: E_MAIL,
          CARTEIRA_CLIENTE: CARTEIRA_CLIENTE,
        );

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'NFCE_CAIXA': NFCE_CAIXA,
      'NOME': NOME,
      'CODFRENTISTA': CODFRENTISTA,
      'CCUSTO': CCUSTO,
      'E_MAIL': E_MAIL,
      'CARTEIRA_CLIENTE': CARTEIRA_CLIENTE,
    };
  }

  static UserDto fromMap(Map map) {
    return UserDto(
      ID: map['ID'],
      NFCE_CAIXA: map['NFCE_CAIXA'],
      NOME: map['NOME'],
      CODFRENTISTA: map['CODFRENTISTA'] ?? '',
      CCUSTO: map['CCUSTO'] ?? 101,
      E_MAIL: map['E_MAIL'] ?? '',
      CARTEIRA_CLIENTE: map['CARTEIRA_CLIENTE'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDto.fromJson(String source) =>
      UserDto.fromMap(json.decode(source));
}
