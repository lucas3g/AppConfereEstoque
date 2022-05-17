import 'package:confere_estoque/src/layers/services/api_service.dart';
import 'package:confere_estoque/src/layers/services/helpers/params.dart';
import 'package:confere_estoque/src/layers/services/shared_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class DioApiServiceImp implements ApiService {
  final Dio dio;

  DioApiServiceImp({required this.dio});

  final ipServer = 'http://${GetIt.I.get<SharedService>().readIpServer()}';
  final cnpj = GetIt.I.get<SharedService>().readCNPJ();

  @override
  Future<Map<String, dynamic>> getUser(LoginParams params) async {
    final result = await dio.get(
      '$ipServer/login/${params.cnpj}',
      options: Options(
        headers: {
          'login': params.login,
          'senha': params.password,
        },
      ),
    );

    return result.data;
  }

  @override
  Future<Map<String, dynamic>> getProduct(ProductParams params) async {
    await Future.delayed(const Duration(seconds: 5));
    final result = await dio.get(
      '$ipServer/produtos/$cnpj',
      options: Options(
        headers: {
          'id': params.codigo,
          'ccusto': params.ccusto,
        },
      ),
    );

    return result.data;
  }
}
