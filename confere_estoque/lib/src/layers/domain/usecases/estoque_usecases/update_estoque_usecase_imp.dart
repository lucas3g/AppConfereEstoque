import 'package:confere_estoque/src/layers/domain/repositories/estoque_repositories/update_estoque_repository.dart';
import 'package:confere_estoque/src/layers/domain/usecases/estoque_usecases/update_estoque_usecase.dart';
import 'package:dartz/dartz.dart';

class UpdateEstoqueUseCaseImp implements UpdateEstoqueUseCase {
  final UpdateEstoqueRepository updateEstoqueRepository;

  UpdateEstoqueUseCaseImp({required this.updateEstoqueRepository});

  @override
  Future<Either<Exception, bool>> call({
    required String codigo,
    required int ccusto,
    required double quantidade,
    required double qtdAntes,
    required String tipoEstoque,
  }) async {
    return await updateEstoqueRepository(
      codigo: codigo,
      ccusto: ccusto,
      quantidade: quantidade,
      qtdAntes: qtdAntes,
      tipoEstoque: tipoEstoque,
    );
  }
}
