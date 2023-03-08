import 'package:card_crm/providers/org_list_provider.dart';
import 'package:card_crm/providers/org_select_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrgSelectorPage extends HookConsumerWidget {
  const OrgSelectorPage({
    required this.overlay,
    super.key,
  });

  final OverlayEntry? overlay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncOrg = ref.watch(orgListProvider);
    return asyncOrg.when(
      data: (data) => Column(
        children: [
          const TextField(),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final org = data[index];
                return ListTile(
                  onTap: () {
                    ref.read(orgSelectProvider.notifier).state = org;
                    overlay?.remove();
                  },
                  title: Text(org.fullName),
                );
              },
            ),
          )
        ],
      ),
      error: (e, _) => const Text('ERROR'),
      loading: () => const Center(
        child: SizedBox.square(
          dimension: 16.0,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
