import 'package:confere_estoque/src/layers/data/datasources/estoque_datasource/get_estoque_datasource.dart';
import 'package:confere_estoque/src/layers/services/api_service.dart';
import 'package:confere_estoque/src/layers/services/helpers/params.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class GetEstoqueApiDataSourceImp implements GetEstoqueDataSource {
  final ApiService _apiService;

  GetEstoqueApiDataSourceImp({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<Exception, Map<String, dynamic>>> call({
    required String codigo,
    required int ccusto,
  }) async {
    try {
      final ProductEstoque params = ProductEstoque(
        codigo: codigo,
        ccusto: ccusto,
      );

      final response = await _apiService.getEstoque(params);

      if (response.isNotEmpty) {
        return Right(response[0]);
      } else {
        return Left(Exception('Error datasource'));
      }
    } on DioError catch (e) {
      return Left(Exception(e.message));
    }
  }
}
