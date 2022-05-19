abstract class ProductEvents {}

class ProductGetEvent extends ProductEvents {
  final String codigo;
  final String descricao;
  final int ccusto;
  ProductGetEvent({
    required this.codigo,
    required this.descricao,
    required this.ccusto,
  });
}
