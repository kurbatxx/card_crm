import 'package:card_crm/api/api.dart';
import 'package:card_crm/model/org_client/org_client.dart';
import 'package:card_crm/providers/init_search_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final initSearchOrgClientsListProvider = FutureProvider<List<OrgClient>>(
  (ref) async {
    final search = ref.watch(initSearchProvider);
    return ref.watch(apiProvider).initSearch(search);
  },
);
