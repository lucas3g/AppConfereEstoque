import 'package:confere_estoque/src/layers/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LoginSigninDataSource {
  Future<Either<Exception, UserEntity>> call({
    required String cnpj,
    required String login,
    required String password,
  });
}
