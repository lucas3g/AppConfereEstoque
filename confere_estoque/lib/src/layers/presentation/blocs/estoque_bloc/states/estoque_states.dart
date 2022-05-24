import 'package:confere_estoque/src/layers/domain/entities/estoque_entity.dart';

abstract class EstoqueStates {}

class EstoqueInitialState extends EstoqueStates {}

class EstoqueLoadingState extends EstoqueStates {}

class EstoqueSuccessState extends EstoqueStates {}

class EstoqueErrorState extends EstoqueStates {
  final String message;
  final StackTrace? stackTrace;
  EstoqueErrorState({
    required this.message,
    this.stackTrace,
  });
}

class EstoqueGetLoadingState extends EstoqueStates {}

class EstoqueGetSuccessState extends EstoqueStates {
  final EstoqueEntity estoqueEntity;

  EstoqueGetSuccessState({
    required this.estoqueEntity,
  });
}

class EstoqueGetErrorState extends EstoqueStates {
  final String message;
  final StackTrace? stackTrace;
  EstoqueGetErrorState({
    required this.message,
    this.stackTrace,
  });
}
