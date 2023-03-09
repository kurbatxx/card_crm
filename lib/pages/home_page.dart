import 'package:card_crm/api/api.dart';
import 'package:card_crm/ext/ext_log.dart';
import 'package:card_crm/pages/org_selector_page.dart';
import 'package:card_crm/providers/initial_provider.dart';
import 'package:card_crm/providers/org_select_provider.dart';
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
    final tabController = useTabController(initialLength: 2);
    final switchValue = useState(false);

    final selectOrg = ref.watch(orgSelectProvider);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TabBar(
          controller: tabController,
          tabs: const [
            Tab(child: Text('Поиск', style: TextStyle(fontSize: 16.0))),
            Tab(child: Text('Заявки', style: TextStyle(fontSize: 16.0))),
          ],
        ),
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
      body: TabBarView(
        controller: tabController,
        children: [
          Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
              SwitchListTile(
                title: const Text('Показывать выбывших'),
                value: switchValue.value,
                onChanged: (bool _) {
                  switchValue.value = !switchValue.value;
                },
              ),
              ListTile(
                onTap: () {
                  showOverlay(context: context);
                },
                title: Text(selectOrg.fullName),
                trailing: IconButton(
                  onPressed: () {
                    ref.invalidate(orgSelectProvider);
                  },
                  icon: const Icon(Icons.clear),
                ),
              )
            ],
          ),
          Column(),
        ],
      ),
    );
  }
}

void showOverlay({
  required BuildContext context,
}) {
  OverlayEntry? overlay;

  final state = Overlay.of(context);
  overlay = OverlayEntry(
    builder: (context) {
      return GestureDetector(
        onTap: () {
          'close overlay'.log();
          overlay?.remove();
        },
        child: Material(
          color: Colors.black.withAlpha(150),
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: GestureDetector(
                onTap: () {},
                child: OrgSelectorPage(
                  overlay: overlay,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );

  state.insert(overlay);
}
