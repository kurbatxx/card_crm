import 'package:card_crm/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: LoginPassWithButton(),
      ),
    );
  }
}

class LoginPassWithButton extends HookConsumerWidget {
  const LoginPassWithButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isMounted = useIsMounted();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Container()),
        TextField(
          controller: loginController,
        ),
        TextField(
          controller: passwordController,
        ),
        const SizedBox(
          height: 8.0,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 300,
            maxWidth: 350,
          ),
          child: Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () async {
                    final login = loginController.text;
                    final password = passwordController.text;

                    if (!await ref.read(apiProvider).login(login, password)) {
                      return;
                    }

                    final mounted = isMounted();
                    if (!mounted) return;
                    context.go('/home');
                  },
                  child: const Text('Войти'),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
