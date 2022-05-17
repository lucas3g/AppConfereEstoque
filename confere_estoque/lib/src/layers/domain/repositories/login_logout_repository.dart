import 'package:dartz/dartz.dart';

abstract class LoginLogOutRepository {
  Future<Either<Exception, bool>> call();
}
