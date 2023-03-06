import 'package:card_crm/api/api.dart';
import 'package:card_crm/ext/ext_log.dart';
import 'package:card_crm/providers/secure_storage_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:http/http.dart' as http;

enum InitialStates {
  noInternet,
  noServerConnection,
  noLoginPassword,
  wrongLoginPassword,
  loginInSystem;
}

class AccessData {
  final String login;
  final String password;

  AccessData(this.login, this.password);

  Map<String, dynamic> toJson() => {
        'login': login,
        'password': password,
      };
}

final initialProvider = FutureProvider<InitialStates>((ref) async {
  await Future.delayed(const Duration(seconds: 1));

  try {
    await http.get(Uri.https('google.com'));
  } catch (e) {
    'ERROR: $e'.log();
    return InitialStates.noInternet;
  }

  final secureStorage = ref.read(secureStorageProvider);

  final address = await secureStorage.read(key: "address") ?? "";
  final port = await secureStorage.read(key: "port") ?? "";

  if (!await ref.read(apiProvider).checkServer(address, port)) {
    return InitialStates.noServerConnection;
  }

  final login = await secureStorage.read(key: "login") ?? "";
  final password = await secureStorage.read(key: "password") ?? "";

  if (login.isEmpty || password.isEmpty) {
    return InitialStates.noLoginPassword;
  }

  if (!await ref.read(apiProvider).login(login, password)) {
    return InitialStates.wrongLoginPassword;
  }

  return InitialStates.loginInSystem;
});
