import 'package:confere_estoque/src/layers/domain/entities/ccustos_entity.dart';

abstract class CCustosStates {}

class CCustosInitialState extends CCustosStates {}

class CCustosLoadingState extends CCustosStates {}

class CCustosSuccessState extends CCustosStates {
  final List<CCustosEntity> listCCustos;
  CCustosSuccessState({
    required this.listCCustos,
  });
}

class CCustosLogOutSuccessState extends CCustosStates {}

class CCustosErrorState extends CCustosStates {
  final String message;
  final StackTrace? stackTrace;
  CCustosErrorState({
    required this.message,
    this.stackTrace,
  });
}
