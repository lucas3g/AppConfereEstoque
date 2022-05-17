import 'package:confere_estoque/src/layers/domain/usecases/ccustos_usecases/ccustos_get_all_usecases.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/ccustos_bloc/events/ccustos_events.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/ccustos_bloc/states/ccustos_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CCustosBloc extends Bloc<CCustosEvents, CCustosStates> {
  final CCustosGetAllUseCase ccustosGetAllUseCase;
  int ccusto;

  CCustosBloc({
    required this.ccustosGetAllUseCase,
    required this.ccusto,
  }) : super(CCustosInitialState()) {
    on<CCustosGetAllEvent>(_getAllCCustos);
  }

  Future<void> _getAllCCustos(CCustosGetAllEvent event, emit) async {
    emit(CCustosLoadingState());
    final result = await ccustosGetAllUseCase();

    result.fold(
      (error) => emit(
        CCustosErrorState(message: error.toString()),
      ),
      (success) => emit(
        CCustosSuccessState(listCCustos: success),
      ),
    );
  }
}
