import 'package:card_crm/api/api.dart';
import 'package:card_crm/providers/secure_storage_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum InitialStates {
  noServerConnection,
  noLoginPassword,
  wrongLoginPassword,
  loginInSystem;
}

class AccessData {
  final String login;
  final String password;

  AccessData(this.login, this.password);
}

final initialProvider = FutureProvider<InitialStates>((ref) async {
  await Future.delayed(const Duration(seconds: 2));
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