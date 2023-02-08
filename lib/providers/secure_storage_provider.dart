import 'package:card_crm/api/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum InitialStates {
  noServerconnection,
  noLoginPassword,
  wrongLoginPassword,
  loginInSystem;
}

class AccessData {
  final String login;
  final String password;

  AccessData(this.login, this.password);
}

final secureStorageProvider = Provider<FlutterSecureStorage>((_) {
  return const FlutterSecureStorage();
});

final loginProvider = FutureProvider<InitialStates>((ref) async {
  final secureStorage = ref.read(secureStorageProvider);

  final login = await secureStorage.read(key: "login") ?? "";
  final password = await secureStorage.read(key: "password") ?? "";

  if (login.isEmpty || password.isEmpty) {
    return InitialStates.noLoginPassword;
  }

  if (await Api.login(login, password)) {
    return InitialStates.wrongLoginPassword;
  }

  return InitialStates.loginInSystem;
});
