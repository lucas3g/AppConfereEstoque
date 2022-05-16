abstract class ProductEvents {}

class ProductGetEvent extends ProductEvents {
  final String codigo;
  final int ccusto;
  ProductGetEvent({
    required this.codigo,
    required this.ccusto,
  });
}
