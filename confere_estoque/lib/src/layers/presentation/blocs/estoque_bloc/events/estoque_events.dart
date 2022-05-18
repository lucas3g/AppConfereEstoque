abstract class EstoqueEvents {}

class UpdateEstoqueEvent extends EstoqueEvents {
  final String codigo;
  final int ccusto;
  final String quantidade;
  final String tipoEstoque;

  UpdateEstoqueEvent({
    required this.codigo,
    required this.ccusto,
    required this.quantidade,
    required this.tipoEstoque,
  });
}
