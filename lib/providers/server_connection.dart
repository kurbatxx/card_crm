import 'package:hooks_riverpod/hooks_riverpod.dart';

class Server {
  final String address;
  final String port;

  Server(this.address, this.port);
}

final serverProvider = StateProvider<Server>((_) {
  return Server("", "");
});
