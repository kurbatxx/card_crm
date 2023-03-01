import 'package:card_crm/providers/initial_provider.dart';
import 'package:card_crm/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  // final wsUrl = Uri.parse('ws://127.0.0.1:3333/ws');
  // var channel = WebSocketChannel.connect(wsUrl);

  runApp(
    ProviderScope(
      child: MaterialApp.router(
        theme: ThemeData(
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        routerConfig: router,
      ),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(initialProvider, (_, next) {
      switch (next.value) {
        case InitialStates.noLoginPassword:
          context.go('/login_page');
          break;
        case InitialStates.noInternet:
          context.go('/no_internet');
          break;
        case InitialStates.noServerConnection:
          context.go('/no_server');
          break;
        case InitialStates.loginInSystem:
          context.go('/home');
          break;
        default:
          context.go('/ups');
      }
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

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
