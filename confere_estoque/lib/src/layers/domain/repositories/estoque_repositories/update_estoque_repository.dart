import 'package:dartz/dartz.dart';

abstract class UpdateEstoqueRepository {
  Future<Either<Exception, bool>> call({
    required String codigo,
    required int ccusto,
    required double quantidade,
    required double qtdAntes,
    required String tipoEstoque,
  });
}
