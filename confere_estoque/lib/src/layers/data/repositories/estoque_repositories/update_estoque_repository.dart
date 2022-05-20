import 'package:confere_estoque/src/layers/data/datasources/estoque_datasource/update_estoque_datasource.dart';
import 'package:confere_estoque/src/layers/domain/repositories/estoque_repositories/update_estoque_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateEstoqueRepositoryImp implements UpdateEstoqueRepository {
  final UpdateEstoqueDataSource updateEstoqueDataSource;

  UpdateEstoqueRepositoryImp({required this.updateEstoqueDataSource});

  @override
  Future<Either<Exception, bool>> call({
    required String codigo,
    required int ccusto,
    required String quantidade,
    required String qtdAntes,
    required String tipoEstoque,
  }) async {
    return await updateEstoqueDataSource(
      codigo: codigo,
      ccusto: ccusto,
      quantidade: quantidade,
      qtdAntes: qtdAntes,
      tipoEstoque: tipoEstoque,
    );
  }
}
