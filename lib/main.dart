import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() async {
  final wsUrl = Uri.parse('ws://127.0.0.1:3333/ws');
  var channel = WebSocketChannel.connect(wsUrl);

  runApp(MainApp(channel: channel));
}

class MainApp extends StatelessWidget {
  final WebSocketChannel channel;
  const MainApp({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () async {
          channel.sink.add('recheived!');
          //channel.sink.close(status.goingAway);
        }),
        body: Center(
          child: StreamBuilder(
            stream: channel.stream.asBroadcastStream(),
            builder: (
              BuildContext context,
              AsyncSnapshot<dynamic> snapshot,
            ) {
              if (snapshot.hasData) {
                return Text(snapshot.toString());
              }
              return const Text("Ничего");
            },
          ),
        ),
        //child: Text('Hello World!'),
      ),
    );
  }
}
