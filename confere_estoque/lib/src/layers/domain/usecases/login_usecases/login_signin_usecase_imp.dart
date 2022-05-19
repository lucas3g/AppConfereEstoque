import 'package:confere_estoque/src/layers/domain/entities/user_entity.dart';
import 'package:confere_estoque/src/layers/domain/repositories/login_repositories/login_signing_repository.dart';
import 'package:confere_estoque/src/layers/domain/usecases/login_usecases/login_signin_usecase.dart';
import 'package:dartz/dartz.dart';

class LoginSignInUseCaseImp implements LoginSignInUseCase {
  final LoginSignInRepository loginSignInRepository;

  LoginSignInUseCaseImp({required this.loginSignInRepository});

  @override
  Future<Either<Exception, UserEntity>> call({
    required String cnpj,
    required String login,
    required String password,
  }) async {
    return await loginSignInRepository(
      cnpj: cnpj,
      login: login,
      password: password,
    );
  }
}
