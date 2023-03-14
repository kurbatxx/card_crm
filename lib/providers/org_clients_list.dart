import 'package:card_crm/model/org_client/org_client.dart';
import 'package:card_crm/providers/init_search_org_clients_list_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final orgClientsListProvider = StateProvider<List<OrgClient>>((ref) {
  final result = ref
      .watch(initSearchOrgClientsListProvider)
      .whenData((value) => value)
      .value;

  if (result != null) {
    return result;
  }
  return [];
});
