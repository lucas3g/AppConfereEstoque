import 'package:dartz/dartz.dart';

abstract class UpdateEstoqueUseCase {
  Future<Either<Exception, bool>> call({
    required String codigo,
    required int ccusto,
    required String quantidade,
    required String tipoEstoque,
  });
}
