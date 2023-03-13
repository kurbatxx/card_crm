import 'package:card_crm/api/api.dart';
import 'package:card_crm/model/organization/organization.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final orgListProvider =
    FutureProvider.autoDispose<List<Organization>>((ref) async {
  return await ref.watch(apiProvider).getOrganization();
});
