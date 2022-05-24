abstract class EstoqueEvents {}

class UpdateEstoqueEvent extends EstoqueEvents {
  final String codigo;
  final int ccusto;
  final double quantidade;
  final double qtdAntes;
  final String tipoEstoque;

  UpdateEstoqueEvent({
    required this.codigo,
    required this.ccusto,
    required this.quantidade,
    required this.qtdAntes,
    required this.tipoEstoque,
  });
}

class GetEstoqueEvent extends EstoqueEvents {
  final String codigo;
  final int ccusto;
  GetEstoqueEvent({
    required this.codigo,
    required this.ccusto,
  });
}
