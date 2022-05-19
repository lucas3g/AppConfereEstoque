import 'package:confere_estoque/src/layers/domain/usecases/product_usecases/product_get_usecase.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/product_bloc/events/product_events.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/product_bloc/states/product_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvents, ProductStates> {
  final ProductGetUseCase productGetUseCase;

  ProductBloc({
    required this.productGetUseCase,
  }) : super(ProductInitialState()) {
    on<ProductGetEvent>(_productGet);
  }

  Future<void> _productGet(ProductGetEvent event, emit) async {
    emit(ProductLoadingState());
    final result = await productGetUseCase(
      codigo: event.codigo,
      descricao: event.descricao,
      ccusto: event.ccusto,
    );

    result.fold(
      (error) => emit(ProductErrorState(
        message: error.toString(),
      )),
      (success) => emit(ProductSuccessState(productEntity: success)),
    );
  }
}
