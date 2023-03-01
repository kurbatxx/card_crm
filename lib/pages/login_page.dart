import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginPassWithButton(),
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
      children: [
        TextField(
          controller: loginController,
        ),
        TextField(
          controller: passwordController,
        ),
        const SizedBox(
          height: 4.0,
        ),
        FilledButton(
          onPressed: () async {
            await Future.delayed(const Duration(seconds: 1));

            final mounted = isMounted();
            if (!mounted) return;
            context.go('/home');
          },
          child: const Text('Войти'),
        )
      ],
    );
  }
}
