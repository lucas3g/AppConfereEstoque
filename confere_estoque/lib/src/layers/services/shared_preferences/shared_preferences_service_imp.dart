import 'package:confere_estoque/src/layers/data/dtos/user_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:confere_estoque/src/layers/domain/entities/user_entity.dart';
import 'package:confere_estoque/src/layers/services/shared_service.dart';

class SharedPreferencesServiceImp implements SharedService {
  final SharedPreferences sharedPreferences;

  SharedPreferencesServiceImp({
    required this.sharedPreferences,
  });

  @override
  Future<bool> setUser({required UserEntity userEntity}) async {
    final UserDto userDto = userEntity as UserDto;
    return await sharedPreferences.setString('user', userDto.toJson());
  }

  @override
  UserEntity readUser() {
    final user = sharedPreferences.getString('user');
    return UserDto.fromJson(user!);
  }

  @override
  Future<bool> setIPServer({required String ip}) async {
    return await sharedPreferences.setString('ip', ip);
  }

  @override
  String readIpServer() {
    final ipServer = sharedPreferences.getString('ip') ?? '';
    return ipServer;
  }

  @override
  bool readLogado() {
    final logado = sharedPreferences.getString('logado');
    return logado == 'S' ? true : false;
  }

  @override
  Future<void> setLogado() async {
    await sharedPreferences.setString('logado', 'S');
  }

  @override
  String readCNPJ() {
    final cnpj = sharedPreferences.getString('cnpj') ?? '';
    return cnpj;
  }

  @override
  Future<void> setCNPJ({required String cnpj}) async {
    await sharedPreferences.setString('cnpj', cnpj);
  }

  @override
  Future<bool> removeLogado() async {
    return await sharedPreferences.remove('user') &&
        await sharedPreferences.remove('logado');
  }

  @override
  String readPortServer() {
    final port = sharedPreferences.getString('port') ?? '';
    return port;
  }

  @override
  Future<bool> setPortServer({required String port}) async {
    return await sharedPreferences.setString('port', port);
  }
}
