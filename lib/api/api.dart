import 'package:card_crm/providers/server_connection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class Api {
  Api(Ref ref) {
    ref = ref;
  }

  static late final Ref ref;

  static Future<bool> checkServer(String serverAdress, String port) async {
    try {
      await http.get(Uri.http('$serverAdress:$port'));
    } catch (e) {
      print('ERROR: $e');
      return false;
    }
    return true;
  }

  static Future<bool> login(String login, String password) async {
    final server = ref.read(serverProvider);

    final resp = await http.get(Uri.http('${server.address}:${server.port}'));
    print(resp.body.toString());
    return true;
  }
}
