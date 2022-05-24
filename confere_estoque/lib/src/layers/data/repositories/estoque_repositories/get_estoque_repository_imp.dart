import 'package:confere_estoque/src/layers/data/datasources/estoque_datasource/get_estoque_datasource.dart';
import 'package:confere_estoque/src/layers/domain/repositories/estoque_repositories/get_estoque_repository.dart';
import 'package:dartz/dartz.dart';

class GetEstoqueRepositoryImp implements GetEstoqueRepository {
  final GetEstoqueDataSource getEstoqueDataSource;

  GetEstoqueRepositoryImp({required this.getEstoqueDataSource});

  @override
  Future<Either<Exception, Map<String, dynamic>>> call({
    required String codigo,
    required int ccusto,
  }) async {
    return await getEstoqueDataSource(
      codigo: codigo,
      ccusto: ccusto,
    );
  }
}
