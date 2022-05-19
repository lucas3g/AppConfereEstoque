import 'package:confere_estoque/src/layers/domain/repositories/login_repositories/login_logout_repository.dart';
import 'package:confere_estoque/src/layers/domain/usecases/login_usecases/login_logout_usecase.dart';
import 'package:dartz/dartz.dart';

class LoginLogOutUseCaseImp implements LoginLogOutUseCase {
  final LoginLogOutRepository loginLogOutRepository;

  LoginLogOutUseCaseImp({required this.loginLogOutRepository});

  @override
  Future<Either<Exception, bool>> call() async {
    return await loginLogOutRepository();
  }
}
