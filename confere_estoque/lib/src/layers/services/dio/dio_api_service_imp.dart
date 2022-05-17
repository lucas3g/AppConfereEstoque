import 'package:confere_estoque/src/layers/services/api_service.dart';
import 'package:confere_estoque/src/layers/services/helpers/params.dart';
import 'package:confere_estoque/src/layers/services/shared_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class DioApiServiceImp implements ApiService {
  final Dio dio;

  DioApiServiceImp({required this.dio});

  @override
  Future<Map<String, dynamic>> getUser(LoginParams params) async {
    final ipServer = 'http://${GetIt.I.get<SharedService>().readIpServer()}';
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
    final ipServer = 'http://${GetIt.I.get<SharedService>().readIpServer()}';
    final cnpj = GetIt.I.get<SharedService>().readCNPJ();
    final result = await dio.get(
      '$ipServer/produtos',
      options: Options(
        headers: {
          'id': params.codigo,
          'ccusto': params.ccusto,
          'cnpj': cnpj,
        },
      ),
    );

    if (result.data.isNotEmpty) {
      return result.data[0];
    } else {
      return {'DESCRICAO': 'Produto não encontrado'};
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllCCustos() async {
    final ipServer = 'http://${GetIt.I.get<SharedService>().readIpServer()}';
    final cnpj = GetIt.I.get<SharedService>().readCNPJ();
    final result = await dio.get(
      '$ipServer/ccustos',
      options: Options(
        headers: {
          'cnpj': cnpj,
        },
      ),
    );

    final listFrom = List<Map<String, dynamic>>.from(result.data);

    return listFrom;
  }
}
