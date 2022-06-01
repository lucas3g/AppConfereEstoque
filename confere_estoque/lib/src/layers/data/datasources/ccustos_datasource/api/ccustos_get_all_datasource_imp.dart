import 'package:confere_estoque/src/layers/data/datasources/ccustos_datasource/ccustos_get_all_datasource.dart';
import 'package:confere_estoque/src/layers/data/dtos/ccustos_dto.dart';
import 'package:confere_estoque/src/layers/domain/entities/ccustos_entity.dart';
import 'package:confere_estoque/src/layers/services/api_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class CCustosGetAllApiDataSourceImp implements CCustosGetAllDataSource {
  final ApiService _apiService;

  CCustosGetAllApiDataSourceImp({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<Exception, List<CCustosEntity>>> call() async {
    try {
      final response = await _apiService.getAllCCustos();

      await Future.delayed(const Duration(seconds: 1));

      if (response.isNotEmpty) {
        late List<CCustosEntity> listCCustos =
            response.map(CCustosDto.fromMap).toList();
        return Right(listCCustos);
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
