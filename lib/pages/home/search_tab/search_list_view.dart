import 'package:card_crm/api/api.dart';

import 'package:card_crm/model/org_client/org_client.dart';
import 'package:card_crm/providers/next_search_page_exist_provider.dart';
import 'package:card_crm/providers/org_clients_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchListView extends HookConsumerWidget {
  const SearchListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollController(initialScrollOffset: 0.0);

    final page = useState(2);
    final isLoading = useState(false);

    useEffect(
      () {
        controller.addListener(() async {
          if (controller.offset == controller.position.maxScrollExtent) {
            if (ref.read(nextSearchPageExistProvider) && !isLoading.value) {
              isLoading.value = true;
              final res = await ref.read(apiProvider).searchPage(page.value);
              ref.read(orgClientsListProvider.notifier).update((state) {
                List<OrgClient> list = [...state, ...res];
                return list;
              });
              page.value += 1;
              isLoading.value = false;
            }
          }
        });

        return null;
      },
      [controller],
    );

    final data = ref.watch(orgClientsListProvider);

    if (data.isEmpty) {
      return const Center(
        child: Text('Ничего не найдено'),
      );
    }

    return ListView.builder(
      controller: controller,
      itemCount: isLoading.value ? data.length + 1 : data.length,
      itemBuilder: (context, index) {
        if (index >= data.length) {
          if (isLoading.value) {
            return const Center(
              child: SizedBox.square(
                dimension: 16.0,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          }
        }

        final orgClient = data[index];
        return ListTile(
          title:
              Text('${orgClient.fullname.lastName} ${orgClient.fullname.name}'),
        );
      },
    );
  }
}
