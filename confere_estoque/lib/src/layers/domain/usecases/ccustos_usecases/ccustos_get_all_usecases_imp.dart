import 'package:confere_estoque/src/layers/domain/entities/ccustos_entity.dart';
import 'package:confere_estoque/src/layers/domain/repositories/ccustos_repositories/ccustos_get_all_repository.dart';
import 'package:confere_estoque/src/layers/domain/usecases/ccustos_usecases/ccustos_get_all_usecases.dart';
import 'package:dartz/dartz.dart';

class CCustosGetAllUseCasesImp implements CCustosGetAllUseCase {
  final CCustosGetAllRepository ccustosGetAllRepository;

  CCustosGetAllUseCasesImp({required this.ccustosGetAllRepository});

  @override
  Future<Either<Exception, List<CCustosEntity>>> call() async {
    return await ccustosGetAllRepository();
  }
}
