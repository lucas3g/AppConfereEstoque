import 'package:confere_estoque/src/layers/data/datasources/login_datasource/login_logout_datasource.dart';
import 'package:confere_estoque/src/layers/domain/repositories/login_repositories/login_logout_repository.dart';
import 'package:dartz/dartz.dart';

class LoginLogOutRepositoryImp implements LoginLogOutRepository {
  final LoginLogOutDataSource loginLogOutDataSource;

  LoginLogOutRepositoryImp({required this.loginLogOutDataSource});

  @override
  Future<Either<Exception, bool>> call() async {
    return await loginLogOutDataSource();
  }
}
