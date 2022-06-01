import 'package:confere_estoque/src/layers/data/datasources/estoque_datasource/update_estoque_datasource.dart';
import 'package:confere_estoque/src/layers/services/api_service.dart';
import 'package:confere_estoque/src/layers/services/helpers/params.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class UpdateEstoqueApiDataSourceImp implements UpdateEstoqueDataSource {
  final ApiService _apiService;

  UpdateEstoqueApiDataSourceImp({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<Exception, bool>> call({
    required String codigo,
    required int ccusto,
    required double quantidade,
    required double qtdAntes,
    required String tipoEstoque,
  }) async {
    try {
      final EstoqueParams params = EstoqueParams(
        codigo: codigo,
        ccusto: ccusto,
        quantidade: quantidade,
        qtdAntes: qtdAntes,
        tipoEstoque: tipoEstoque,
      );

      final response = await _apiService.insertEstoque(params);

      if (response) {
        return const Right(true);
      } else {
        return Left(Exception('Error datasource'));
      }
    } on DioError catch (e) {
      if (e.message.contains('time')) {
        return Left(Exception('Perda de conexão...'));
      }
      return Left(Exception(e.message));
    }
  }
}
