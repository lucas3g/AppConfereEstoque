import 'package:confere_estoque/src/layers/data/datasources/product_datasource/product_get_datasource.dart';
import 'package:confere_estoque/src/layers/domain/entities/product_entity.dart';
import 'package:confere_estoque/src/layers/domain/repositories/product_repositories/product_get_repository.dart';
import 'package:dartz/dartz.dart';

class ProductGetRepositoryImp implements ProductGetRepository {
  final ProductGetDataSource productGetDataSource;

  ProductGetRepositoryImp({required this.productGetDataSource});

  @override
  Future<Either<Exception, List<ProductEntity>>> call({
    required String codigo,
    required String descricao,
    required int ccusto,
  }) async {
    return await productGetDataSource(
      codigo: codigo,
      descricao: descricao,
      ccusto: ccusto,
    );
  }
}
