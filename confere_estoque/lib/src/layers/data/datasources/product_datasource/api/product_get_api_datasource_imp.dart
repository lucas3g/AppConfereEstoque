import 'package:confere_estoque/src/layers/data/datasources/product_datasource/product_get_datasource.dart';
import 'package:confere_estoque/src/layers/data/dtos/product_dto.dart';
import 'package:confere_estoque/src/layers/domain/entities/product_entity.dart';
import 'package:confere_estoque/src/layers/services/api_service.dart';
import 'package:confere_estoque/src/layers/services/helpers/params.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ProductGetApiDataSourceImp implements ProductGetDataSource {
  final ApiService _apiService;

  ProductGetApiDataSourceImp({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<Exception, List<ProductEntity>>> call({
    required String codigo,
    required String descricao,
    required int ccusto,
  }) async {
    try {
      final ProductParams params = ProductParams(
        codigo: codigo,
        descricao: descricao,
        ccusto: ccusto,
      );

      final response = await _apiService.getProduct(params);

      if (response[0]['DESCRICAO'] == 'Produto não encontrado') {
        return Left(Exception('Produto não encontrado'));
      }

      if (response.isNotEmpty && response.length == 1) {
        late List<ProductEntity> productEntity =
            response.map(ProductDto.fromMap).toList();

        final ProductEstoque paramsEstoque = ProductEstoque(
          codigo: productEntity[0].ID,
          ccusto: ccusto,
        );

        final responseEstoque = await _apiService.getEstoque(paramsEstoque);

        productEntity[0].EST_ATUAL = 0.0;
        productEntity[0].EST_FISICO = 0.0;
        productEntity[0].EST_CONTADO =
            responseEstoque[0]['QTD_NOVO'].toDouble() ?? 0.0;

        return Right(productEntity);
      }

      if (response.isNotEmpty && response.length > 1) {
        late List<ProductEntity> productEntity =
            response.map(ProductDto.fromMap).toList();

        productEntity[0].EST_ATUAL = 0.0;
        productEntity[0].EST_FISICO = 0.0;
        productEntity[0].EST_CONTADO = 0.0;

        return Right(productEntity);
      }

      return Left(Exception('Erro no datasource'));
    } on DioError catch (e) {
      if (e.message.contains('time')) {
        return Left(Exception('Perda de conexão...'));
      }
      return Left(Exception(e.message));
    }
  }
}
