import 'package:card_crm/api/api.dart';
import 'package:card_crm/ext/ext_log.dart';
import 'package:card_crm/providers/initial_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgIsLoading = useState(false);

    final isMounted = useIsMounted();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: orgIsLoading.value
                ? null
                : () async {
                    orgIsLoading.value = true;
                    final org = await ref.read(apiProvider).getOrganization();
                    org.log();
                    orgIsLoading.value = false;
                  },
            icon: orgIsLoading.value
                ? const SizedBox.square(
                    dimension: 16,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.check),
          ),
          IconButton(
            onPressed: () async {
              if (!await ref.read(apiProvider).logout()) {
                return;
              }

              final mounted = isMounted();
              if (!mounted) return;
              context.go('/');
              final _ = ref.refresh(initialProvider);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
