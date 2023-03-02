import 'package:card_crm/api/api.dart';
import 'package:card_crm/providers/initial_provider.dart';
import 'package:card_crm/providers/server_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ServerSettingPage extends StatelessWidget {
  const ServerSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SettingFieldsWithButton(),
      ),
    );
  }
}

class SettingFieldsWithButton extends HookConsumerWidget {
  const SettingFieldsWithButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final server = ref.watch(serverProvider);

    final serverAdressController =
        useTextEditingController(text: server.address);
    final portController = useTextEditingController(text: server.port);

    final isMounted = useIsMounted();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Сервер не доступен, проверьте доступность адреса или измените адрес сервера',
        ),
        Row(
          children: [
            Flexible(
              flex: 4,
              child: TextField(
                controller: serverAdressController,
              ),
            ),
            Flexible(
              child: TextField(
                controller: portController,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 4.0,
        ),
        Flexible(
          child: FilledButton(
            onPressed: () async {
              final address = serverAdressController.text;
              final port = portController.text;
              if (await ref.read(apiProvider).checkServer(address, port)) {
                final mounted = isMounted();
                if (!mounted) return;
                context.go('/');
                final _ = ref.refresh(initialProvider);
              }
            },
            child: const Text('Подключиться'),
          ),
        )
      ],
    );
  }
}


//json.encode