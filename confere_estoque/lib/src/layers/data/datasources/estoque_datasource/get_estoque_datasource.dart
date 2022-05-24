import 'package:dartz/dartz.dart';

abstract class GetEstoqueDataSource {
  Future<Either<Exception, Map<String, dynamic>>> call({
    required String codigo,
    required int ccusto,
  });
}
