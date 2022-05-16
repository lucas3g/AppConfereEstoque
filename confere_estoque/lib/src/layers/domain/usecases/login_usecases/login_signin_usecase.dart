import 'package:dartz/dartz.dart';
import 'package:confere_estoque/src/layers/domain/entities/user_entity.dart';

abstract class LoginSignInUseCase {
  Future<Either<Exception, UserEntity>> call(
      {required String cnpj, required String login, required String password});
}
