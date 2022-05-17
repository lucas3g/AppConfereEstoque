import 'package:confere_estoque/src/layers/data/datasources/ccustos_datasource/ccustos_get_all_datasource.dart';
import 'package:confere_estoque/src/layers/domain/entities/ccustos_entity.dart';
import 'package:confere_estoque/src/layers/domain/repositories/ccustos_repositories/ccustos_get_all_repository.dart';
import 'package:dartz/dartz.dart';

class CCustosGetAllRepositoryImp implements CCustosGetAllRepository {
  final CCustosGetAllDataSource ccustosGetAllDataSource;

  CCustosGetAllRepositoryImp({required this.ccustosGetAllDataSource});

  @override
  Future<Either<Exception, List<CCustosEntity>>> call() async {
    return await ccustosGetAllDataSource();
  }
}
