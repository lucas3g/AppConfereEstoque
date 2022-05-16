import 'package:confere_estoque/src/layers/data/datasources/login_signin_datasource/login_signin_datasource.dart';
import 'package:confere_estoque/src/layers/domain/entities/user_entity.dart';
import 'package:confere_estoque/src/layers/domain/repositories/login_signing_repository.dart';
import 'package:dartz/dartz.dart';

class LoginSignInRepositoryImp implements LoginSignInRepository {
  final LoginSigninDataSource loginSigninDataSource;

  LoginSignInRepositoryImp({required this.loginSigninDataSource});

  @override
  Future<Either<Exception, UserEntity>> call({
    required String cnpj,
    required String login,
    required String password,
  }) async {
    return await loginSigninDataSource(
      cnpj: cnpj,
      login: login,
      password: password,
    );
  }
}
