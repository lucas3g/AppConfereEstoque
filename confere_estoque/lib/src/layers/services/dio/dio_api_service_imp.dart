import 'package:confere_estoque/src/layers/services/api_service.dart';
import 'package:confere_estoque/src/layers/services/helpers/params.dart';
import 'package:confere_estoque/src/layers/services/shared_service.dart';
import 'package:confere_estoque/src/utils/formatters.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class DioApiServiceImp implements ApiService {
  final Dio dio;

  DioApiServiceImp({required this.dio});

  @override
  Future<Map<String, dynamic>> getUser(LoginParams params) async {
    final ipServer = 'http://${GetIt.I.get<SharedService>().readIpServer()}';
    final result = await dio.get(
      '$ipServer/login/',
      options: Options(
        headers: {
          'cnpj': params.cnpj,
          'usuario': params.login,
          'senha': params.password,
        },
      ),
    );

    return result.data;
  }

  @override
  Future<List<Map<String, dynamic>>> getProduct(ProductParams params) async {
    final ipServer = 'http://${GetIt.I.get<SharedService>().readIpServer()}';
    final cnpj = GetIt.I.get<SharedService>().readCNPJ();
    final result = await dio.get(
      '$ipServer/produtos',
      options: Options(
        headers: {
          'cnpj': cnpj,
          'field': params.codigo.isNotEmpty ? 'ID' : 'DESCRICAO',
          'value': params.codigo.isNotEmpty ? params.codigo : params.descricao,
        },
      ),
    );

    if (params.codigo.isNotEmpty && result.data.isNotEmpty) {
      return List<Map<String, dynamic>>.from(result.data);
    }

    if (params.descricao.isNotEmpty && result.data.isNotEmpty) {
      final listFrom = List<Map<String, dynamic>>.from(result.data);
      return listFrom;
    }

    return [
      {'DESCRICAO': 'Produto não encontrado'}
    ];
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

  @override
  Future<bool> insertEstoque(EstoqueParams params) async {
    final ipServer = 'http://${GetIt.I.get<SharedService>().readIpServer()}';
    final cnpj = GetIt.I.get<SharedService>().readCNPJ();
    final result = await dio.post(
      '$ipServer/conferencia_estoque/${params.codigo}',
      data: {
        'CCUSTO': params.ccusto,
        'MERCADORIA': params.codigo,
        'DATA': DateTime.now().toIso8601String(),
        'QTD_NOVO': params.qtdAntes.estoque() + params.quantidade.estoque(),
        'QTD_ANTES': params.qtdAntes,
        'QTD_AJUSTADO': params.quantidade,
        'AJUSTADO': 'N',
        'CONTABIL_FISICO': params.tipoEstoque == 'C' ? 'C' : 'F',
      },
      options: Options(
        headers: {
          'cnpj': cnpj,
          'ccusto': params.ccusto,
        },
      ),
    );

    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getEstoque(ProductEstoque params) async {
    final ipServer = 'http://${GetIt.I.get<SharedService>().readIpServer()}';
    final cnpj = GetIt.I.get<SharedService>().readCNPJ();
    final result = await dio.get(
      '$ipServer/estoque/${params.codigo}',
      options: Options(
        headers: {
          'id': params.codigo,
          'ccusto': params.ccusto,
          'cnpj': cnpj,
        },
      ),
    );

    if (result.statusCode == 200) {
      return List<Map<String, dynamic>>.from(result.data);
    } else {
      return List<Map<String, dynamic>>.from([
        {'EST_ATUAL': 0, 'EST_FISICO': 0}
      ]);
    }
  }
}
