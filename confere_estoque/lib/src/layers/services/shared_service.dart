import 'package:confere_estoque/src/layers/domain/entities/user_entity.dart';

abstract class SharedService {
  Future<bool> setUser({required UserEntity userEntity});
  Future<bool> setIPServer({required String ip});
  Future<bool> setPortServer({required String port});
  Future<void> setCNPJ({required String cnpj});
  UserEntity readUser();
  String readIpServer();
  String readPortServer();
  String readCNPJ();
  bool readLogado();
  Future<void> setLogado();
  Future<bool> removeLogado();
}
