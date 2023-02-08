import 'package:card_crm/providers/secure_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  final wsUrl = Uri.parse('ws://127.0.0.1:3333/ws');
  var channel = WebSocketChannel.connect(wsUrl);

  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        darkTheme: ThemeData.dark(),
        home: const App(),
      ),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginProvider, (_, next) {
      print(next.value);
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () async {
      //   channel.sink.add('recheived!');
      //   //channel.sink.close(status.goingAway);
      // }),
      // body: Center(
      //   child: StreamBuilder(
      //     stream: channel.stream.asBroadcastStream(),
      //     builder: (
      //       BuildContext context,
      //       AsyncSnapshot<dynamic> snapshot,
      //     ) {
      //       if (snapshot.hasData) {
      //         return Text(snapshot.toString());
      //       }
      //       return const Text("Ничего");
      //     },
      //   ),
      // ),
      // //child: Text('Hello World!'),
    );
  }
}
