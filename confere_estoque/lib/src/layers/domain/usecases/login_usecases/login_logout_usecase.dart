import 'package:dartz/dartz.dart';

abstract class LoginLogOutUseCase {
  Future<Either<Exception, bool>> call();
}
