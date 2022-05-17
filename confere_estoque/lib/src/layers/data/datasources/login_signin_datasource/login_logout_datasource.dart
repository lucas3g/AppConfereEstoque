import 'package:dartz/dartz.dart';

abstract class LoginLogOutDataSource {
  Future<Either<Exception, bool>> call();
}
