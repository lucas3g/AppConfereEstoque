// ignore_for_file: non_constant_identifier_names

class UserEntity {
  final int ID;
  final int NFCE_CAIXA;
  final String NOME;
  final String? CODFRENTISTA;
  final int? CCUSTO;
  final String? E_MAIL;
  final int? CARTEIRA_CLIENTE;

  UserEntity({
    required this.ID,
    required this.NFCE_CAIXA,
    required this.NOME,
    this.CODFRENTISTA,
    this.CCUSTO,
    this.E_MAIL,
    this.CARTEIRA_CLIENTE,
  });
}
