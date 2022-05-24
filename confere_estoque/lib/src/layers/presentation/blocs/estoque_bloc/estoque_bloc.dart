import 'package:confere_estoque/src/layers/data/dtos/estoque_dto.dart';
import 'package:confere_estoque/src/layers/domain/usecases/estoque_usecases/get_estoque_usecase.dart';
import 'package:confere_estoque/src/layers/domain/usecases/estoque_usecases/update_estoque_usecase.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/estoque_bloc/events/estoque_events.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/estoque_bloc/states/estoque_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Estoques { fisico, contabil }

class EstoqueBloc extends Bloc<EstoqueEvents, EstoqueStates> {
  final UpdateEstoqueUseCase updateEstoqueUseCase;
  final GetEstoqueUseCase getEstoqueUseCase;
  late Estoques estoques;

  EstoqueBloc({
    required this.updateEstoqueUseCase,
    required this.getEstoqueUseCase,
    required this.estoques,
  }) : super(EstoqueInitialState()) {
    on<UpdateEstoqueEvent>(_updateEstoque);
    on<GetEstoqueEvent>(_getEstoque);
  }

  Future<void> _updateEstoque(UpdateEstoqueEvent event, emit) async {
    emit(EstoqueLoadingState());
    final result = await updateEstoqueUseCase(
      codigo: event.codigo,
      ccusto: event.ccusto,
      quantidade: event.quantidade,
      qtdAntes: event.qtdAntes,
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

  Future<void> _getEstoque(GetEstoqueEvent event, emit) async {
    emit(EstoqueGetLoadingState());
    final result = await getEstoqueUseCase(
      codigo: event.codigo,
      ccusto: event.ccusto,
    );

    result.fold(
      (error) => emit(EstoqueGetErrorState(
        message: error.toString(),
      )),
      (success) => emit(
        EstoqueGetSuccessState(estoqueEntity: EstoqueDto.fromMap(success)),
      ),
    );
  }
}
