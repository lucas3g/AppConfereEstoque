import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:confere_estoque/src/layers/domain/usecases/login_usecases/login_signin_usecase.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/login_bloc/events/login_events.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/login_bloc/states/login_states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final LoginSignInUseCase loginSignInUseCase;

  LoginBloc({
    required this.loginSignInUseCase,
  }) : super(LoginInitialState()) {
    on<LoginSignInEvent>(_loginSignIn);
  }

  Future<void> _loginSignIn(LoginSignInEvent event, emit) async {
    emit(LoginLoadingState());
    final result = await loginSignInUseCase(
        cnpj: event.cnpj, login: event.login, password: event.password);

    result.fold(
      (error) => emit(LoginErrorState(
        message: error.toString(),
      )),
      (success) => emit(LoginSuccessState(userEntity: success)),
    );
  }
}
