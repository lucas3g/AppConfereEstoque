import 'package:confere_estoque/src/layers/domain/repositories/estoque_repositories/get_estoque_repository.dart';
import 'package:confere_estoque/src/layers/domain/usecases/estoque_usecases/get_estoque_usecase.dart';
import 'package:dartz/dartz.dart';

class GetEstoqueUseCaseImp implements GetEstoqueUseCase {
  final GetEstoqueRepository getEstoqueRepository;

  GetEstoqueUseCaseImp({required this.getEstoqueRepository});

  @override
  Future<Either<Exception, Map<String, dynamic>>> call({
    required String codigo,
    required int ccusto,
  }) async {
    return await getEstoqueRepository(
      codigo: codigo,
      ccusto: ccusto,
    );
  }
}
