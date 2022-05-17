import 'package:confere_estoque/src/layers/domain/entities/ccustos_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CCustosGetAllUseCase {
  Future<Either<Exception, List<CCustosEntity>>> call();
}
