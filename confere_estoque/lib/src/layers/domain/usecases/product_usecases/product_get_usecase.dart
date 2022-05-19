import 'package:confere_estoque/src/layers/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductGetUseCase {
  Future<Either<Exception, List<ProductEntity>>> call({
    required String codigo,
    required String descricao,
    required int ccusto,
  });
}
