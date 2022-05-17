import 'package:confere_estoque/src/layers/domain/entities/user_entity.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final UserEntity userEntity;
  LoginSuccessState({
    required this.userEntity,
  });
}

class LoginLogOutSuccessState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String message;
  final StackTrace? stackTrace;
  LoginErrorState({
    required this.message,
    this.stackTrace,
  });
}
