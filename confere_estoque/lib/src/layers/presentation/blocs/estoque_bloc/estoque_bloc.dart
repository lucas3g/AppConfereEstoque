import 'package:confere_estoque/src/layers/domain/usecases/estoque_usecases/update_estoque_usecase.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/estoque_bloc/events/estoque_events.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/estoque_bloc/states/estoque_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Estoques { fisico, contabil }

class EstoqueBloc extends Bloc<EstoqueEvents, EstoqueStates> {
  final UpdateEstoqueUseCase updateEstoqueUseCase;
  late Estoques estoques;

  EstoqueBloc({
    required this.updateEstoqueUseCase,
    required this.estoques,
  }) : super(EstoqueInitialState()) {
    on<UpdateEstoqueEvent>(_updateEstoque);
  }

  Future<void> _updateEstoque(UpdateEstoqueEvent event, emit) async {
    emit(EstoqueLoadingState());
    final result = await updateEstoqueUseCase(
      codigo: event.codigo,
      ccusto: event.ccusto,
      quantidade: event.quantidade,
      tipoEstoque: event.tipoEstoque,
    );

    result.fold(
      (error) => emit(EstoqueErrorState(
        message: error.toString(),
      )),
      (success) => emit(
        EstoqueSuccessState(),
      ),
    );
  }
}
