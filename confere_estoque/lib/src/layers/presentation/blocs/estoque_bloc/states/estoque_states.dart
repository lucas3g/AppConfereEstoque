abstract class EstoqueStates {}

class EstoqueInitialState extends EstoqueStates {}

class EstoqueLoadingState extends EstoqueStates {}

class EstoqueSuccessState extends EstoqueStates {}

class EstoqueLogOutSuccessState extends EstoqueStates {}

class EstoqueErrorState extends EstoqueStates {
  final String message;
  final StackTrace? stackTrace;
  EstoqueErrorState({
    required this.message,
    this.stackTrace,
  });
}
