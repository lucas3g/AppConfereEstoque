import 'package:confere_estoque/src/layers/data/datasources/login_signin_datasource/login_logout_datasource.dart';
import 'package:confere_estoque/src/layers/services/shared_service.dart';
import 'package:dartz/dartz.dart';

class LoginLogOutLocalDataSourceImp implements LoginLogOutDataSource {
  final SharedService _sharedService;

  LoginLogOutLocalDataSourceImp({required SharedService sharedService})
      : _sharedService = sharedService;

  @override
  Future<Either<Exception, bool>> call() async {
    try {
      final response = await _sharedService.removeLogado();

      return Right(response);
    } catch (e) {
      return Left(Exception('Error datasource'));
    }
  }
}
