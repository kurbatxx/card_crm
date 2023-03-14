import 'package:card_crm/providers/org_clients_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchListView extends ConsumerWidget {
  const SearchListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(orgClientsListProvider);
    if (data.isEmpty) {
      return const Center(
        child: Text('Ничего не найдено'),
      );
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final orgClient = data[index];
        return ListTile(
          title: Text(orgClient.name),
        );
      },
    );
  }
}
