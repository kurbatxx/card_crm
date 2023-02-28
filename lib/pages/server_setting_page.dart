import 'package:flutter/material.dart';

class ServerSettingPage extends StatelessWidget {
  const ServerSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Сервер не доступен, проверьте доступность адреса или измените адрес сервера',
            ),
            Row(
              children: const [
                Flexible(
                  flex: 4,
                  child: TextField(),
                ),
                Flexible(child: TextField()),
              ],
            ),
            Flexible(
              child: FilledButton(
                onPressed: () {},
                child: const Text('Подключиться'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
