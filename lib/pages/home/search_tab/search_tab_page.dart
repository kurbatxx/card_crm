import 'package:card_crm/ext/ext_log.dart';
import 'package:card_crm/model/init_search/init_search.dart';
import 'package:card_crm/pages/home/search_tab/search_list_view.dart';
import 'package:card_crm/pages/org_selector_page.dart';
import 'package:card_crm/providers/init_search_provider.dart';
import 'package:card_crm/providers/init_search_org_clients_list_provider.dart';
import 'package:card_crm/providers/org_select_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchTabPageWidget extends HookConsumerWidget {
  const SearchTabPageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final init = useState(false);
    final switchValue = useState(false);

    final selectOrg = ref.watch(orgSelectProvider);
    final searchController = useTextEditingController();
    final orgClients = ref.watch(initSearchOrgClientsListProvider);

    return Column(
      children: [
        TextField(
          controller: searchController,
          onSubmitted: (_) {
            searchController.text.log();
            init.value = true;
            final org = ref.read(orgSelectProvider);
            ref.read(initSearchProvider.notifier).state = InitSearch(
              search: searchController.text,
              schoolId: org.id,
              deleted: switchValue.value,
            );
          },
          decoration: InputDecoration(
            hintText: 'ФИО или ID',
            suffixIcon: IconButton(
              onPressed: () {
                searchController.clear();
              },
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
        ),
        Expanded(
          child: !init.value
              ? const Center(
                  child: Text('Начните поиск, чтобы получить результат'),
                )
              : orgClients.when(
                  //skipLoadingOnRefresh: false,
                  data: (data) {
                    data.log();
                    return const SearchListView();
                  },
                  error: (_, __) => const Center(
                    child: Text('Ошибка поиска'),
                  ),
                  loading: () => const Center(
                    child: SizedBox.square(
                      dimension: 16.0,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
        ),
      ],
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
