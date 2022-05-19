import 'package:confere_estoque/src/layers/domain/entities/product_entity.dart';
import 'package:confere_estoque/src/layers/domain/repositories/product_repositories/product_get_repository.dart';
import 'package:confere_estoque/src/layers/domain/usecases/product_usecases/product_get_usecase.dart';
import 'package:dartz/dartz.dart';

class ProductGetUseCaseImp implements ProductGetUseCase {
  final ProductGetRepository productGetRepository;

  ProductGetUseCaseImp({required this.productGetRepository});

  @override
  Future<Either<Exception, List<ProductEntity>>> call({
    required String codigo,
    required String descricao,
    required int ccusto,
  }) async {
    return await productGetRepository(
      codigo: codigo,
      descricao: descricao,
      ccusto: ccusto,
    );
  }
}
