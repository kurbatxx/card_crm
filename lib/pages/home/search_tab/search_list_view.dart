import 'package:card_crm/api/api.dart';
import 'package:card_crm/ext/ext_log.dart';
import 'package:card_crm/providers/org_clients_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchListView extends HookConsumerWidget {
  const SearchListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollController(initialScrollOffset: 0.0);

    useEffect(
      () {
        controller.addListener(() {
          controller.position.log();
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
      itemCount: data.length,
      itemBuilder: (context, index) {
        if (data.length - 1 == index) {
          ref.read(apiProvider).searchPage(2);
        }
        final orgClient = data[index];
        return ListTile(
          title: Text(orgClient.name),
        );
      },
    );
  }
}
