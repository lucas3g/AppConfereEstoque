import 'package:confere_estoque/src/layers/domain/entities/product_entity.dart';

abstract class ProductStates {}

class ProductInitialState extends ProductStates {}

class ProductLoadingState extends ProductStates {}

class ProductSuccessState extends ProductStates {
  final List<ProductEntity> productEntity;
  ProductSuccessState({
    required this.productEntity,
  });
}

class ProductErrorState extends ProductStates {
  final String message;
  final StackTrace? stackTrace;
  ProductErrorState({
    required this.message,
    this.stackTrace,
  });
}
