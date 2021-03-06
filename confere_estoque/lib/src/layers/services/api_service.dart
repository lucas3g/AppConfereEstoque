import 'package:confere_estoque/src/layers/services/helpers/params.dart';

abstract class ApiService {
  Future<Map<String, dynamic>> getUser(LoginParams params);
  Future<List<Map<String, dynamic>>> getProduct(ProductParams params);
  Future<List<Map<String, dynamic>>> getEstoque(ProductEstoque params);
  Future<List<Map<String, dynamic>>> getAllCCustos();
  Future<bool> insertEstoque(EstoqueParams params);
}
