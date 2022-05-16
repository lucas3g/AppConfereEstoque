import 'package:confere_estoque/src/layers/data/datasources/login_signin_datasource/login_signin_datasource.dart';
import 'package:confere_estoque/src/layers/data/dtos/user_dto.dart';
import 'package:confere_estoque/src/layers/domain/entities/user_entity.dart';
import 'package:confere_estoque/src/layers/services/api_service.dart';
import 'package:confere_estoque/src/layers/services/helpers/params.dart';
import 'package:confere_estoque/src/layers/services/shared_service.dart';
import 'package:dartz/dartz.dart';

class LoginSignInApiDataSourceImp implements LoginSigninDataSource {
  final ApiService _apiService;
  final SharedService _sharedService;

  LoginSignInApiDataSourceImp(
      {required ApiService apiService, required SharedService sharedService})
      : _apiService = apiService,
        _sharedService = sharedService;

  @override
  Future<Either<Exception, UserEntity>> call({
    required String cnpj,
    required String login,
    required String password,
  }) async {
    try {
      final cnpjSemCaracter =
          cnpj.replaceAll('.', '').replaceAll('/', '').replaceAll('-', '');

      final LoginParams params =
          LoginParams(cnpj: cnpjSemCaracter, login: login, password: password);

      final response = await _apiService.getUser(params);

      await Future.delayed(const Duration(seconds: 1));

      if (response.isNotEmpty) {
        final UserEntity userEntity = UserDto.fromMap(response);
        await _sharedService.setUser(userEntity: userEntity);
        await _sharedService.setLogado();
        await _sharedService.setCNPJ(cnpj: cnpjSemCaracter);
        return Right(userEntity);
      } else {
        return Left(Exception('Error datasource'));
      }
    } catch (e) {
      return Left(Exception('Error datasource'));
    }
  }
}
